-- Core Keymaps
-- This file contains all basic key mappings that don't depend on plugins

-- Clear search highlighting with Esc in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Open diagnostic quickfix list
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode easier (normally Ctrl+\ then Ctrl+N)
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation with Ctrl+hjkl
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Session management (requires persistence.nvim plugin)
vim.keymap.set("n", "<leader>qs", function()
  require("persistence").load()
end, { desc = 'Load session for current directory' })

vim.keymap.set("n", "<leader>qS", function()
  require("persistence").select()
end, { desc = 'Select a session to load' })
