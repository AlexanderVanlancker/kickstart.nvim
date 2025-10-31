-- Colorscheme
-- Defines the visual theme for Neovim

return {
  'folke/tokyonight.nvim',
  priority = 1000, -- Load before other plugins
  config = function()
    require('tokyonight').setup {
      styles = {
        comments = { italic = false }, -- Disable italics in comments
      },
    }

    -- Apply the colorscheme
    vim.cmd.colorscheme 'tokyonight-night'
  end,
}
