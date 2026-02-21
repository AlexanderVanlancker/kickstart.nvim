-- Telescope Fuzzy Finder
-- Powerful search tool for files, text, LSP symbols, and more

return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      -- Fast fuzzy finder (requires make to build)
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            -- Ctrl + j/k for navigating up/down in insert mode
            ['<C-j>'] = require('telescope.actions').move_selection_next,
            ['<C-k>'] = require('telescope.actions').move_selection_previous,
            -- Ctrl + h/l for horizontal scrolling in preview
            ['<C-h>'] = require('telescope.actions').preview_scrolling_left,
            ['<C-l>'] = require('telescope.actions').preview_scrolling_right,
          },
          n = {
            -- Ctrl + j/k for navigating up/down in normal mode
            ['<C-j>'] = require('telescope.actions').move_selection_next,
            ['<C-k>'] = require('telescope.actions').move_selection_previous,
            -- Ctrl + h/l for horizontal scrolling in preview
            ['<C-h>'] = require('telescope.actions').preview_scrolling_left,
            ['<C-l>'] = require('telescope.actions').preview_scrolling_right,
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable extensions
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- Fix Telescope highlights for transparency
    local function fix_telescope_highlights()
      vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'TelescopePreviewNormal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'TelescopeResultsNormal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = 'none' })
    end

    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = fix_telescope_highlights,
    })
    fix_telescope_highlights()

    -- Keymaps
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })
    vim.keymap.set('n', '<leader>sc', '<cmd>Themery<cr>', { desc = '[S]earch [C]olorscheme' })

    -- Search in current buffer
    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- Search in open files
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Search Neovim config files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
