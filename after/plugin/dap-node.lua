local M = {}

function M.setup()
  local dap = require('dap')
  
  -- Node.js adapter - simple attach-only configuration
  -- This uses Node.js built-in inspector protocol (no additional tools needed)
  dap.adapters.node = function(callback, config)
    if config.type == 'attach' then
      callback({
        type = 'server',
        host = config.host or 'localhost',
        port = config.port or 4242,
      })
    end
  end
  
  -- TypeScript/JavaScript configurations
  -- Using simple attach mode - you'll need to run your app with --inspect first
  dap.configurations.typescript = {
    {
      type = 'node',
      request = 'attach',
      name = 'Attach to NestJS (Port 4242)',
      port = 4242,
      host = 'localhost',
      sourceMaps = true,
      protocol = 'inspector',
      skipFiles = { '<node_internals>/**', 'node_modules/**' },
      localRoot = vim.fn.getcwd(),
      remoteRoot = vim.fn.getcwd(),
    },
    {
      type = 'node',
      request = 'attach',
      name = 'Attach to Any Port',
      port = function()
        local port = vim.fn.input('Port: ', '4242')
        return tonumber(port)
      end,
      host = 'localhost',
      sourceMaps = true,
      protocol = 'inspector',
      skipFiles = { '<node_internals>/**', 'node_modules/**' },
      localRoot = vim.fn.getcwd(),
      remoteRoot = vim.fn.getcwd(),
    },
  }
  
  -- Use the same configurations for JavaScript
  dap.configurations.javascript = dap.configurations.typescript
  
  -- Helper function to start NestJS in debug mode
  local function start_nestjs_debug()
    vim.notify('Starting NestJS in debug mode on port 4242...', vim.log.levels.INFO)
    vim.fn.jobstart('npm run start:debug', {
      cwd = vim.fn.getcwd(),
      on_stdout = function(_, data)
        if data then
          for _, line in ipairs(data) do
            if line:match('Debugger listening') or line:match('4242') then
              vim.notify('NestJS debugger ready! Press <leader>dc to attach.', vim.log.levels.INFO)
            end
          end
        end
      end,
      on_exit = function(_, code)
        if code ~= 0 then
          vim.notify('NestJS debug server exited with code ' .. code, vim.log.levels.WARN)
        end
      end,
    })
  end
  
  -- Keymaps for NestJS debugging
  vim.keymap.set('n', '<leader>dN', function()
    vim.fn.jobstart('npm run build', {
      cwd = vim.fn.getcwd(),
      on_exit = function(_, code)
        if code == 0 then
          vim.notify('NestJS Build succeeded', vim.log.levels.INFO)
        else
          vim.notify('NestJS Build failed', vim.log.levels.ERROR)
        end
      end,
    })
  end, { desc = '[D]AP [N]estJS Build' })
  
  vim.keymap.set('n', '<leader>ds', start_nestjs_debug, { desc = '[D]AP [S]tart NestJS Debug Server' })
  
  vim.keymap.set('n', '<leader>dA', function()
    start_nestjs_debug()
    -- Wait a bit for the server to start, then attach
    vim.defer_fn(function()
      require('dap').continue()
    end, 2000)
  end, { desc = '[D]AP [A]uto-start and Attach to NestJS' })
end

vim.defer_fn(M.setup, 100)
