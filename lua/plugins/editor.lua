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
}
