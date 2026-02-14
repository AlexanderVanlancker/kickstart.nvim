-- Autocommands
-- This file contains automatic commands that run on certain events

-- Highlight text when yanking (copying)
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Angular filetype detection
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  desc = 'Detect Angular HTML templates',
  group = vim.api.nvim_create_augroup('angular-filetype', { clear = true }),
  pattern = { '*.component.html', '*.ng.html' },
  callback = function()
    vim.bo.filetype = 'htmlangular'
  end,
})

-- Focus main window on startup (not explorer sidebar)
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Focus main window instead of explorer on startup',
  group = vim.api.nvim_create_augroup('focus-main-window', { clear = true }),
  callback = function()
    -- Delay to ensure all plugins are loaded
    vim.defer_fn(function()
      -- Find the first normal buffer window (not explorer, not special buffers)
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buftype = vim.api.nvim_get_option_value('buftype', { buf = buf })
        local filetype = vim.api.nvim_get_option_value('filetype', { buf = buf })
        
        -- Focus the first normal buffer (not explorer/terminal/special buffers)
        if buftype == '' and filetype ~= 'snacks_explorer' then
          vim.api.nvim_set_current_win(win)
          return
        end
      end
    end, 10) -- Small delay to ensure plugins are fully initialized
  end,
})
