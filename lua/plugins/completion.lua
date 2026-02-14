-- Completion Plugins
-- Provide intelligent code completion as you type

return {
  -- Blink.cmp - Modern completion engine
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    opts = {
      keymap = {
        -- Use 'default' preset (Ctrl+Y to accept)
        -- Or 'super-tab' (Tab to accept)
        -- Or 'enter' (Enter to accept)
        preset = 'default',

        -- All presets include:
        -- Tab/Shift-Tab: move through snippet placeholders
        -- Ctrl-Space: show completion menu
        -- Ctrl-N/Ctrl-P or Up/Down: select items
        -- Ctrl-E: hide menu
        -- Ctrl-K: toggle signature help
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        documentation = {
          auto_show = false,       -- Press Ctrl-Space to show docs
          auto_show_delay_ms = 500,
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = {
            module = 'lazydev.integrations.blink',
            score_offset = 100
          },
        },
      },

      snippets = { preset = 'luasnip' },

      fuzzy = { implementation = 'lua' },

      signature = { enabled = true },
    },
  },
}
