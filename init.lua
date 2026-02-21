--[[
  Neovim Configuration

  This is the main entry point for your Neovim configuration.
  All settings are organized into small, focused files that are easy to understand.

  File Structure:

  lua/core/         - Core Neovim settings
    options.lua     - Basic settings (line numbers, indentation, etc.)
    keymaps.lua     - Keyboard shortcuts
    autocmds.lua    - Automatic commands
    lazy.lua        - Plugin manager setup

  lua/plugins/      - Plugin configurations (each plugin in its own file)
    colorscheme.lua - Visual theme
    completion.lua  - Code completion (blink.cmp, nvim-cmp)
    editor.lua      - Editor enhancements (gitsigns, todo-comments, etc.)
    formatting.lua  - Code formatting (conform.nvim)
    lsp.lua         - Language servers (LSP configuration)
    navigation.lua  - Movement tools (hop.nvim)
    telescope.lua   - Fuzzy finder
    treesitter.lua  - Syntax highlighting
    ui.lua          - UI improvements (which-key, mini.nvim, snacks.nvim)

  To modify settings:
  - Change basic settings: edit lua/core/options.lua
  - Change keyboard shortcuts: edit lua/core/keymaps.lua
  - Add/remove plugins: edit files in lua/plugins/
  - Change plugin settings: edit the specific plugin file
--]]

-- Load core configuration
require('core.options')   -- Basic Neovim settings
require('core.keymaps')   -- Keyboard shortcuts
require('core.autocmds')  -- Automatic commands
require('core.neovide')   -- Neovide specific configuration
require('core.lazy')      -- Plugin manager (loads all plugins from lua/plugins/)
