-- Navigation Plugins
-- Tools for moving around files and code quickly

return {
  -- Quick jump to any location with hop
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })

      local hop = require('hop')
      local directions = require('hop.hint').HintDirection

      -- Jump to character on current line (like f/F in vim)
      vim.keymap.set('', 'f', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, { remap = true, desc = 'Hop forward to char' })

      vim.keymap.set('', 'F', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, { remap = true, desc = 'Hop backward to char' })

      -- Jump before character (like t/T in vim)
      vim.keymap.set('', 't', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end, { remap = true, desc = 'Hop forward before char' })

      vim.keymap.set('', 'T', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      end, { remap = true, desc = 'Hop backward before char' })

      -- Jump to any line
      vim.keymap.set('', '<leader>j', function()
        hop.hint_lines_skip_whitespace()
      end, { desc = 'Hop to line' })

      vim.keymap.set('', '<leader>k', function()
        hop.hint_lines_skip_whitespace({ direction = directions.BEFORE_CURSOR })
      end, { desc = 'Hop to line (reverse)' })

      -- Jump to any word
      vim.keymap.set('', '<leader>w', function()
        hop.hint_words()
      end, { desc = 'Hop to word' })

      vim.keymap.set('', '<leader>e', function()
        hop.hint_words({ direction = directions.BEFORE_CURSOR })
      end, { desc = 'Hop to word (reverse)' })
    end,
  },

  -- Quick bookmarks and navigation
  {
    'otavioschwanck/arrow.nvim',
    config = function()
      require('arrow').setup({
        show_icons = true,
        leader_key = ';', -- Recommended to be a single key
        buffer_leader_key = 'm', -- Per Buffer Mappings
      })
    end,
  },
}
