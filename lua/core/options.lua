-- Core Neovim Options
-- This file contains all the basic Neovim settings like line numbers, indentation, etc.

-- Set leaders before anything else
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = false

-- Line numbers
vim.o.number = true           -- Show line numbers
vim.o.relativenumber = true   -- Show relative line numbers for easier jumping

-- Mouse support
vim.o.mouse = 'a'              -- Enable mouse for resizing splits, etc.

-- Don't show mode in command line (status line shows it)
vim.o.showmode = false

-- Clipboard sync with OS
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'  -- Use system clipboard
end)

-- Indentation
vim.o.tabstop = 2             -- Tab displays as 2 spaces
vim.o.shiftwidth = 2          -- Indent/outdent by 2 spaces
vim.o.expandtab = true        -- Use spaces instead of tabs
vim.o.softtabstop = 2         -- Insert 2 spaces when pressing tab
vim.o.breakindent = true      -- Wrapped lines continue visually indented

-- Undo history
vim.o.undofile = true         -- Save undo history to file

-- Search
vim.o.ignorecase = true       -- Case-insensitive search by default
vim.o.smartcase = true        -- But case-sensitive if search contains uppercase

-- UI
vim.o.signcolumn = 'yes'      -- Always show sign column (prevents text shift)
vim.o.cursorline = true       -- Highlight current line
vim.o.scrolloff = 10          -- Keep 10 lines visible above/below cursor

-- Timings
vim.o.updatetime = 250        -- Faster completion and CursorHold events
vim.o.timeoutlen = 300        -- Time to wait for key sequence completion

-- Splits
vim.o.splitright = true       -- New vertical splits go right
vim.o.splitbelow = true       -- New horizontal splits go below

-- Whitespace characters
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Live preview for substitutions
vim.o.inccommand = 'split'

-- Confirm before closing unsaved buffers
vim.o.confirm = true

-- Terminal shell configuration (fix for macOS zsh path)
vim.o.shell = '/bin/zsh'
vim.o.shellcmdflag = '-i -c'
vim.o.shellredir = '&>'
