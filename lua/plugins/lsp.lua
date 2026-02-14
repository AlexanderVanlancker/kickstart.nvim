-- LSP Configuration
-- Language Server Protocol - provides code intelligence features
-- like go-to-definition, find-references, autocomplete, etc.

return {
  -- Lua LSP configuration for Neovim
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  -- LSP status updates
  { 'j-hui/fidget.nvim', opts = {} },

  -- Main LSP configuration (using native nvim 0.11+ API, no lspconfig plugin needed)
  {
    dir = vim.fn.stdpath('config'),
    name = 'native-lsp-config',
    lazy = false,
    priority = 100,
    config = function()
      -- Set TypeScript path for Angular Language Server
      -- Try Homebrew location first, fallback to /usr/local
      local ts_paths = {
        '/opt/homebrew/lib/node_modules/typescript/lib/tsserverlibrary.js',
        '/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js',
      }
      for _, path in ipairs(ts_paths) do
        if vim.fn.filereadable(path) == 1 then
          vim.env.TSSERVER_PATH = path
          break
        end
      end

      -- This runs when an LSP connects to a buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          -- Helper to create LSP keymaps
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- LSP keymaps
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- Additional shortcuts
          map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gy', vim.lsp.buf.type_definition, '[G]oto t[Y]pe Definition')
          map('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

          -- Helper to check LSP method support
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- Highlight references under cursor
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Toggle inlay hints
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic configuration
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            return diagnostic.message
          end,
        },
      }

       -- Get completion capabilities from blink.cmp
       local capabilities = require('blink.cmp').get_lsp_capabilities()

       -- Setup LSP servers using the new vim.lsp.config API (nvim 0.11+)
       local servers = {
         -- TypeScript Language Server (for .ts files)
         {
           name = 'ts_ls',
           config = {
             cmd = { 'typescript-language-server', '--stdio' },
             filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
             init_options = {
               preferences = {
                 includeInlayParameterNameHints = 'all',
                 includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                 includeInlayFunctionParameterTypeHints = true,
                 includeInlayVariableTypeHints = true,
                 includeInlayPropertyDeclarationTypeHints = true,
                 includeInlayFunctionLikeReturnTypeHints = true,
                 includeInlayEnumMemberValueHints = true,
               },
             },
           },
         },

         -- Angular Language Server with proper TypeScript setup
         {
           name = 'angularls',
           config = {
             filetypes = { 'typescript', 'html', 'typescriptreact', 'typescript.tsx', 'htmlangular' },
             cmd = {
               'ngserver',
               '--stdio',
               '--tsProbeLocations',
               '/opt/homebrew/lib/node_modules',
               '/usr/local/lib/node_modules',
               '--ngProbeLocations',
               '/opt/homebrew/lib/node_modules',
               '/usr/local/lib/node_modules',
             },
           },
         },

          -- Lua Language Server
          {
            name = 'lua_ls',
            config = {
              settings = {
                Lua = {
                  completion = {
                    callSnippet = 'Replace',
                  },
                },
              },
            },
          },
        }



       -- Setup LSP servers using the new vim.lsp.config API
       local server_names = {}
       for _, server_entry in ipairs(servers) do
         local server_name = server_entry.name
         local server_config = server_entry.config
         server_config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_config.capabilities or {})
         vim.lsp.config(server_name, server_config)
         table.insert(server_names, server_name)
       end
       -- Enable all configured LSP servers
       vim.lsp.enable(server_names)
    end,
  },

  -- Roslyn LSP for C#/.NET
  {
    'seblyng/roslyn.nvim',
    ft = 'cs',
    opts = {},
  },

  -- LSP Saga for better UI
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('lspsaga').setup {
        ui = {
          theme = 'round',
          border = 'rounded',
          winblend = 0,
          expand = '',
          collapse = '',
          code_action = '💡',
          incoming = ' ',
          outgoing = ' ',
        },
        lightbulb = {
          enable = false,  -- Disable the floating lightbulb (optional)
          sign = false,
        },
        -- Key bindings for lspsaga windows
        keys = {
          quit = { 'q', '<ESC>' },
        },
      }

      -- Keymaps
      vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', { desc = 'Code action' })
      vim.keymap.set('v', '<leader>ca', '<cmd>Lspsaga code_action<CR>', { desc = 'Code action' })
    end,
  },
}
