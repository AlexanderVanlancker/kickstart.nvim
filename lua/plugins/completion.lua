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
        build = (function()
          -- Build regex support (not supported on Windows without make)
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
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

  -- nvim-cmp - Alternative completion (older but stable)
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.abort(),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
      })
    end,
  },
}
