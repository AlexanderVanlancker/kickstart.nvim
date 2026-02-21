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

-- Force transparency for all colorschemes
local function apply_transparency()
  local highlights = {
    'Normal',
    'NormalNC',
    'NormalFloat',
    'FloatBorder',
    'SignColumn',
    'EndOfBuffer',
    'MsgArea',
    'Pmenu',
    'PmenuSel',
    'PmenuSbar',
    'PmenuThumb',
  }
  for _, group in ipairs(highlights) do
    local current = vim.api.nvim_get_hl(0, { name = group })
    local opts = { bg = 'none', ctermbg = 'none' }
    if current.fg then
      opts.fg = current.fg
    end
    vim.api.nvim_set_hl(0, group, opts)
  end
end

vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
  desc = 'Force transparency for all colorschemes',
  group = vim.api.nvim_create_augroup('force-transparency', { clear = true }),
  callback = function()
    vim.schedule(apply_transparency)
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Force transparency on startup',
  group = vim.api.nvim_create_augroup('force-transparency-vimenter', { clear = true }),
  callback = apply_transparency,
})

-- Custom pastel highlights (pink + lavender + mint)
local function apply_pastel_highlights()
  local colors = {
    pink = '#f5c2e7',
    lavender = '#b4befe',
    mint = '#a6e3a1',
  }

  local highlights = {
    -- Search
    Search = { bg = colors.pink, fg = '#1e1e2e' },
    IncSearch = { bg = colors.mint, fg = '#1e1e2e' },
    CurSearch = { bg = colors.pink, fg = '#1e1e2e' },

    -- Visual selection
    Visual = { bg = colors.lavender, fg = '#1e1e2e' },

    -- Cursor line
    CursorLine = { bg = '#2a2a3e' },
    CursorLineNr = { fg = colors.pink, bold = true },

    -- Popup menu
    PmenuSel = { bg = colors.pink, fg = '#1e1e2e' },

    -- Diagnostics
    DiagnosticError = { fg = colors.pink },
    DiagnosticWarn = { fg = colors.lavender },
    DiagnosticInfo = { fg = colors.mint },
    DiagnosticHint = { fg = colors.lavender },

    -- Git
    GitSignsAdd = { fg = colors.mint },
    GitSignsChange = { fg = colors.lavender },
    GitSignsDelete = { fg = colors.pink },

    -- Telescope
    TelescopeSelection = { bg = colors.pink, fg = '#1e1e2e' },
    TelescopeMatching = { fg = colors.mint, bold = true },
    TelescopeBorder = { fg = colors.lavender },

    -- Which-key
    WhichKey = { fg = colors.pink },
    WhichKeyDesc = { fg = colors.lavender },
    WhichKeySeparator = { fg = colors.mint },
  }

  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

vim.api.nvim_create_autocmd('ColorScheme', {
  desc = 'Apply custom pastel highlights',
  group = vim.api.nvim_create_augroup('pastel-highlights', { clear = true }),
  callback = function()
    vim.schedule(apply_pastel_highlights)
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Apply custom pastel highlights on startup',
  group = vim.api.nvim_create_augroup('pastel-highlights-vimenter', { clear = true }),
  callback = apply_pastel_highlights,
})

-- Create a cute notification when you save
vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Notify on file save",
  group = vim.api.nvim_create_augroup('save-notify', { clear = true }),
  callback = function()
    if _G.Snacks then
      Snacks.notifier.notify("Saved! ✨ ฅ^•ﻌ•^ฅ", "info", {
        style = "compact",
        icon = "🐾",
      })
    end
  end,
})
