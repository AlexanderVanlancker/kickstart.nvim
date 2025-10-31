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
