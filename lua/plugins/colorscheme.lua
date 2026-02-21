-- Colorscheme
-- Defines the visual theme for Neovim

return {
  {
    'folke/tokyonight.nvim',
    lazy = true,
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
        comments = { italic = false },
      },
    },
  },
  {
    -- Anime-themed colorschemes (doki-theme)
    'doki-theme/doki-theme-vim',
    lazy = true,
  },
  {
    'maxmx03/fluoromachine.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'shaunsingh/moonlight.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'sainnhe/gruvbox-material',
    lazy = true,
    priority = 1000,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true,
    priority = 1000,
  },
  {
    -- Everforest: warm, nature-inspired colorscheme
    'sainnhe/everforest',
    lazy = true,
    init = function()
      vim.g.everforest_better_performance = 1
    end,
  },
  {
    -- Theme switcher with live preview and persistence
    'zaldih/themery.nvim',
    lazy = false,
    priority = 999,
    config = function()
      require('themery').setup {
        livePreview = true,
        themes = {
          -- Tokyo Night variants (set their own Normal bg natively)
          { name = 'Tokyo Night', colorscheme = 'tokyonight-night' },
          { name = 'Tokyo Storm', colorscheme = 'tokyonight-storm' },
          { name = 'Tokyo Moon', colorscheme = 'tokyonight-moon' },
          { name = 'Tokyo Day', colorscheme = 'tokyonight-day' },
          -- Doki themes (dark)
          { name = 'Zero Two Dark Rose', colorscheme = 'zero_two_dark_rose' },
          { name = 'Zero Two Dark Obsidian', colorscheme = 'zero_two_dark_obsidian' },
          { name = 'Rem', colorscheme = 'rem' },
          { name = 'Ram', colorscheme = 'ram' },
          { name = 'Emilia Dark', colorscheme = 'emilia_dark' },
          { name = 'Beatrice', colorscheme = 'beatrice' },
          { name = 'Megumin', colorscheme = 'megumin' },
          { name = 'Monika Dark', colorscheme = 'monika_dark' },
          { name = 'Natsuki Dark', colorscheme = 'natsuki_dark' },
          { name = 'Sayori Dark', colorscheme = 'sayori_dark' },
          { name = 'Yuri Dark', colorscheme = 'yuri_dark' },
          -- Everforest variants (dark)
          {
            name = 'Everforest Dark Hard',
            colorscheme = 'everforest',
            before = [[vim.o.background = 'dark'; vim.g.everforest_background = 'hard']],
          },
          {
            name = 'Everforest Dark Medium',
            colorscheme = 'everforest',
            before = [[vim.o.background = 'dark'; vim.g.everforest_background = 'medium']],
          },
          {
            name = 'Everforest Dark Soft',
            colorscheme = 'everforest',
            before = [[vim.o.background = 'dark'; vim.g.everforest_background = 'soft']],
          },
          -- Everforest variants (light)
          {
            name = 'Everforest Light Hard',
            colorscheme = 'everforest',
            before = [[vim.o.background = 'light'; vim.g.everforest_background = 'hard']],
          },
          {
            name = 'Everforest Light Medium',
            colorscheme = 'everforest',
            before = [[vim.o.background = 'light'; vim.g.everforest_background = 'medium']],
          },
          {
            name = 'Everforest Light Soft',
            colorscheme = 'everforest',
            before = [[vim.o.background = 'light'; vim.g.everforest_background = 'soft']],
          },
          -- Doki themes (light)
          { name = 'Zero Two Light Lily', colorscheme = 'zero_two_light_lily' },
          { name = 'Zero Two Light Sakura', colorscheme = 'zero_two_light_sakura' },
          { name = 'Emilia Light', colorscheme = 'emilia_light' },
          { name = 'Monika Light', colorscheme = 'monika_light' },
          { name = 'Natsuki Light', colorscheme = 'natsuki_light' },
          { name = 'Sayori Light', colorscheme = 'sayori_light' },
          { name = 'Yuri Light', colorscheme = 'yuri_light' },
          -- Fluoromachine
          { name = 'Fluoromachine', colorscheme = 'fluoromachine' },
          -- Moonlight
          { name = 'Moonlight', colorscheme = 'moonlight' },
          -- Gruvbox Material
          { name = 'Gruvbox Material', colorscheme = 'gruvbox-material' },
          -- Rose Pine
          { name = 'Rose Pine', colorscheme = 'rose-pine' },
          { name = 'Rose Pine Moon', colorscheme = 'rose-pine-moon' },
          { name = 'Rose Pine Dawn', colorscheme = 'rose-pine-dawn' },
        },
      }
    end,
  },
}
