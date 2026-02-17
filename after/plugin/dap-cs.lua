local M = {}

M.netcoredbg_path = '/usr/local/netcoredbg'

function M.get_dotnet_dll()
  local cwd = vim.fn.getcwd()
  local csproj_files = vim.fn.glob(cwd .. '/*.csproj', false, true)
  
  if #csproj_files == 0 then
    return vim.fn.input('Path to dll: ', cwd .. '/bin/Debug/', 'file')
  end
  
  local csproj = csproj_files[1]
  local project_name = vim.fn.fnamemodify(csproj, ':t:r')
  
  local content = vim.fn.readfile(csproj)
  local framework = nil
  for _, line in ipairs(content) do
    local match = line:match('<TargetFramework>([^<]+)</TargetFramework>')
    if match then
      framework = match
      break
    end
  end
  
  if not framework then
    local bin_dir = cwd .. '/bin/Debug/'
    local frameworks = vim.fn.glob(bin_dir .. 'net*', false, true)
    if #frameworks > 0 then
      framework = vim.fn.fnamemodify(frameworks[1], ':t')
    end
  end
  
  if framework then
    local dll = cwd .. '/bin/Debug/' .. framework .. '/' .. project_name .. '.dll'
    if vim.fn.filereadable(dll) == 1 then
      return dll
    end
  end
  
  return vim.fn.input('Path to dll: ', cwd .. '/bin/Debug/', 'file')
end

function M.setup()
  local dap = require('dap')
  
  dap.adapters.coreclr = {
    type = 'executable',
    command = M.netcoredbg_path,
    args = { '--interpreter=vscode' },
  }
  
  dap.configurations.cs = {
    {
      type = 'coreclr',
      name = 'launch - netcoredbg',
      request = 'launch',
      program = M.get_dotnet_dll,
      cwd = '${workspaceFolder}',
      console = 'integratedTerminal',
      stopOnEntry = false,
    },
    {
      type = 'coreclr',
      name = 'launch - Intigriti.Core.Api',
      request = 'launch',
      program = '${workspaceFolder}/Api/Intigriti.Core.Api/bin/Debug/net10.0/Intigriti.Core.Api.dll',
      cwd = '${workspaceFolder}/Api/Intigriti.Core.Api',
      env = {
        ASPNETCORE_ENVIRONMENT = 'Local',
      },
      console = 'integratedTerminal',
      stopOnEntry = false,
    },
    {
      type = 'coreclr',
      name = 'launch - Intigriti.BFF',
      request = 'launch',
      program = '/Users/Alexander/intigriti/bff/Intigriti.BFF.Proxy/bin/Debug/net10.0/Intigriti.BFF.Proxy.dll',
      cwd = '/Users/Alexander/intigriti/bff/Intigriti.BFF.Proxy',
      env = {
        ASPNETCORE_ENVIRONMENT = 'Local',
        ASPNETCORE_URLS = 'https://localhost:9999'
      },
      console = 'integratedTerminal',
      stopOnEntry = false,
    },
    {
      type = 'coreclr',
      name = 'launch - Intigriti.Identity',
      request = 'launch',
      program = '/Users/Alexander/Intigriti/identity/Intigriti.Identity.Application/bin/Debug/net10.0/Intigriti.Identity.Application.dll',
      cwd = '/Users/Alexander/Intigriti/identity/Intigriti.Identity.Application',
      env = {
        ASPNETCORE_ENVIRONMENT = 'Local',
        ASPNETCORE_URLS = 'https://localhost:7000;https://localhost:7001',
      },
      console = 'integratedTerminal',
      stopOnEntry = false,
    },
    {
      type = 'coreclr',
      name = 'attach - netcoredbg',
      request = 'attach',
      processId = function()
        local utils = require('dap.utils')
        return utils.pick_process({ filter = 'dotnet' })
      end,
    },
    {
      type = 'coreclr',
      name = 'attach - Intigriti.Core.Api',
      request = 'attach',
      processId = function()
        local utils = require('dap.utils')
        return utils.pick_process({ filter = 'Intigriti.Core.Api' })
      end,
    },
    {
      type = 'coreclr',
      name = 'attach - Intigriti.Identity',
      request = 'attach',
      processId = function()
        local utils = require('dap.utils')
        return utils.pick_process({ filter = 'Intigriti.Identity' })
      end,
    },
    {
      type = 'coreclr',
      name = 'attach - Intigriti.BFF',
      request = 'attach',
      processId = function()
        local utils = require('dap.utils')
        return utils.pick_process({ filter = 'Intigriti.BFF' })
      end,
    },
  }
  
  vim.keymap.set('n', '<leader>dc', require('dap').continue, { desc = '[D]AP [C]ontinue / Launch' })
  vim.keymap.set('n', '<leader>dC', function()
    vim.fn.jobstart('dotnet build Api/Intigriti.Core.Api', {
      cwd = vim.fn.getcwd(),
      on_exit = function(_, code)
        if code == 0 then
          vim.notify('Build succeeded', vim.log.levels.INFO)
        else
          vim.notify('Build failed', vim.log.levels.ERROR)
        end
      end,
    })
  end, { desc = '[D]AP [C]ompile API' })
  
  vim.keymap.set('n', '<leader>dI', function()
    vim.fn.jobstart('dotnet build /Users/Alexander/Intigriti/identity/Intigriti.Identity.Application', {
      cwd = vim.fn.getcwd(),
      on_exit = function(_, code)
        if code == 0 then
          vim.notify('Identity Build succeeded', vim.log.levels.INFO)
        else
          vim.notify('Identity Build failed', vim.log.levels.ERROR)
        end
      end,
    })
  end, { desc = '[D]AP [I]dentity Compile' })
  
  vim.keymap.set('n', '<leader>dB', function()
    vim.fn.jobstart('dotnet build /Users/Alexander/intigriti/bff/Intigriti.BFF.Proxy', {
      cwd = vim.fn.getcwd(),
      on_exit = function(_, code)
        if code == 0 then
          vim.notify('BFF Build succeeded', vim.log.levels.INFO)
        else
          vim.notify('BFF Build failed', vim.log.levels.ERROR)
        end
      end,
    })
  end, { desc = '[D]AP [B]FF Compile' })
  
  vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint, { desc = '[D]AP Toggle [B]reakpoint' })
  vim.keymap.set('n', '<leader>dK', function()
    require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
  end, { desc = '[D]AP Conditional [B]reakpoint' })
  vim.keymap.set('n', '<leader>dlp', function()
    require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
  end, { desc = '[D]AP [L]og [P]oint' })
  vim.keymap.set('n', '<leader>do', require('dap').step_over, { desc = '[D]AP Step [O]ver' })
  vim.keymap.set('n', '<leader>di', require('dap').step_into, { desc = '[D]AP Step [I]nto' })
  vim.keymap.set('n', '<leader>dO', require('dap').step_out, { desc = '[D]AP Step [O]ut' })
  vim.keymap.set('n', '<leader>dR', require('dap').restart, { desc = '[D]AP [R]estart' })
  vim.keymap.set('n', '<leader>dS', require('dap').terminate, { desc = '[D]AP [S]top' })
  vim.keymap.set('n', '<leader>du', require('dapui').toggle, { desc = '[D]AP [U]I Toggle' })
  vim.keymap.set('n', '<leader>dr', require('dap').repl.toggle, { desc = '[D]AP [R]EPL Toggle' })
  vim.keymap.set('n', '<leader>dj', function()
    require('dap').down()
  end, { desc = '[D]AP Down Stack' })
  vim.keymap.set('n', '<leader>dk', function()
    require('dap').up()
  end, { desc = '[D]AP Up Stack' })
  vim.keymap.set('n', '<leader>dlr', function()
    require('dap').run_last()
  end, { desc = '[D]AP [L]ast [R]un' })
  vim.keymap.set('n', '<leader>de', function()
    require('dapui').eval()
  end, { desc = '[D]AP [E]val' })
  vim.keymap.set('v', '<leader>de', function()
    require('dapui').eval()
  end, { desc = '[D]AP [E]val Selection' })
end

vim.defer_fn(M.setup, 100)
