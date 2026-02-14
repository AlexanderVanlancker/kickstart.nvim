return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '●', texthl = 'DiagnosticSignWarn', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint', { text = '◆', texthl = 'DiagnosticSignInfo', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DiagnosticSignHint', linehl = 'CursorLine', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '○', texthl = 'DiagnosticSignHint', linehl = '', numhl = '' })
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'mfussenegger/nvim-dap',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      
      dapui.setup({
        icons = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
        mappings = {
          expand = { '<CR>', '<2-LeftMouse>' },
          open = 'o',
          remove = 'd',
          edit = 'e',
          repl = 'r',
          toggle = 't',
        },
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 0.40 },
              { id = 'breakpoints', size = 0.20 },
              { id = 'stacks', size = 0.20 },
              { id = 'watches', size = 0.20 },
            },
            size = 40,
            position = 'left',
          },
          {
            elements = {
              { id = 'repl', size = 0.5 },
              { id = 'console', size = 0.5 },
            },
            size = 10,
            position = 'bottom',
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = 'single',
          mappings = {
            close = { 'q', '<Esc>' },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil,
          max_value_lines = 100,
        },
      })
      
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
  { 'nvim-neotest/nvim-nio' },
}
