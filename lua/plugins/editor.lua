-- Editor Enhancement Plugins
-- Tools that improve the editing experience

return {
  -- Auto-detect tab settings
  'NMAC427/guess-indent.nvim',

  -- Git signs in the gutter
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- Git diff viewer
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = '[G]it [D]iff View' },
      { '<leader>gh', '<cmd>DiffviewFileHistory<cr>', desc = '[G]it File [H]istory' },
      { '<leader>gH', '<cmd>DiffviewFileHistory %<cr>', desc = '[G]it Current File [H]istory' },
      { '<leader>gc', '<cmd>DiffviewClose<cr>', desc = '[G]it Diff [C]lose' },
    },
    opts = {},
  },

  -- Highlight TODO comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }
  },

  -- Session persistence
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },

  -- TreeSitter text objects for selecting functions, classes, etc.
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
        },
      })
    end,
  },

  -- Task runner
  {
    'stevearc/overseer.nvim',
    keys = {
      { '<leader>or', '<cmd>OverseerRun<cr>', desc = '[O]verseer [R]un' },
      { '<leader>ot', '<cmd>OverseerToggle<cr>', desc = '[O]verseer [T]oggle' },
      { '<leader>oq', '<cmd>OverseerQuickAction<cr>', desc = '[O]verseer [Q]uick Action' },
      { '<leader>ol', '<cmd>OverseerLoadBundle<cr>', desc = '[O]verseer [L]oad Bundle' },
      { '<leader>os', '<cmd>OverseerSaveBundle<cr>', desc = '[O]verseer [S]ave Bundle' },
    },
    config = function()
      require('overseer').setup({
        templates = { "builtin", "core", "web", "other", "leaderboard" },
        task_list = {
          direction = 'bottom',
          min_height = 10,
          max_height = 20,
          default_detail = 1,
          bindings = {
            ['q'] = 'Close',
            ['<cr>'] = 'RunAction',
            ['<c-e>'] = 'Edit',
            ['o'] = 'Open',
            ['<c-v>'] = 'OpenVsplit',
            ['<c-s>'] = 'OpenSplit',
            ['<c-f>'] = 'OpenFloat',
            ['<c-q>'] = 'OpenQuickFix',
            ['<c-l>'] = 'IncreaseDetail',
            ['<c-h>'] = 'DecreaseDetail',
            ['R'] = 'Restart',
            ['S'] = 'Stop',
            ['D'] = 'Dispose',
            ['<leader>r'] = 'Restart',
            ['<leader>s'] = 'Stop',
            ['<leader>d'] = 'Dispose',
          },
        },
        auto_close_on_success = true,
        auto_scroll = {
          enabled = true,
          direction = 'down',
          min_height = 10,
          max_height = 20,
        },
      })
    end,
  },

  -- Terminal management
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    keys = {
      { '<C-\\>', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' },
      { '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', desc = '[T]erminal [F]loat' },
      { '<leader>th', '<cmd>ToggleTerm direction=horizontal<cr>', desc = '[T]erminal [H]orizontal' },
      { '<leader>tv', '<cmd>ToggleTerm direction=vertical<cr>', desc = '[T]erminal [V]ertical' },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = 'float',
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = 'curved',
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    },
  },

  -- AI-powered editor assistant
  {
    'nickjvandyke/opencode.nvim',
    dependencies = {
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
      vim.g.opencode_opts = {}

      vim.o.autoread = true

      -- Recommended keymaps
      vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
      vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end, { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })

      vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end, { desc = "Add range to opencode", expr = true })
      vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

      vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end, { desc = "Scroll opencode up" })
      vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })

      vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
      vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
    end,
  },
}
