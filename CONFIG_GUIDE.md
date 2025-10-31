# Neovim Configuration Guide

This configuration has been reorganized into a modular, easy-to-understand structure. Each file has a specific purpose and is well-commented.

## File Structure

```
~/.config/nvim/
├── init.lua              # Main entry point (loads everything)
├── lua/
│   ├── core/            # Core Neovim settings
│   │   ├── options.lua  # Basic settings (line numbers, tabs, etc.)
│   │   ├── keymaps.lua  # Keyboard shortcuts
│   │   ├── autocmds.lua # Automatic commands
│   │   └── lazy.lua     # Plugin manager setup
│   └── plugins/         # Plugin configurations
│       ├── colorscheme.lua  # Visual theme (tokyonight)
│       ├── completion.lua   # Code completion
│       ├── editor.lua       # Editor enhancements
│       ├── formatting.lua   # Code formatting
│       ├── lsp.lua          # Language servers
│       ├── navigation.lua   # Quick navigation (hop.nvim)
│       ├── telescope.lua    # Fuzzy finder
│       ├── treesitter.lua   # Syntax highlighting
│       └── ui.lua           # UI improvements
```

## How It Works

1. **init.lua** - The main file that Neovim loads first
   - Loads core settings from `lua/core/`
   - Each `require()` statement loads a different module

2. **lua/core/** - Basic Neovim configuration
   - `options.lua` - Settings like line numbers, indentation, search behavior
   - `keymaps.lua` - Keyboard shortcuts (Ctrl+hjkl for window navigation, etc.)
   - `autocmds.lua` - Things that happen automatically (like highlighting yanked text)
   - `lazy.lua` - Sets up the plugin manager and loads all plugins

3. **lua/plugins/** - Each file configures specific plugins
   - Each file returns a Lua table with plugin configurations
   - Lazy.nvim automatically loads all files in this directory

## Making Changes

### Change Basic Settings
Edit `lua/core/options.lua`:
- Line numbers: `vim.o.number` and `vim.o.relativenumber`
- Tab size: Add `vim.o.tabstop`, `vim.o.shiftwidth`
- Mouse: `vim.o.mouse`

### Add/Change Keyboard Shortcuts
Edit `lua/core/keymaps.lua`:
```lua
vim.keymap.set('n', '<leader>w', '<cmd>write<CR>', { desc = 'Save file' })
```

### Add a New Plugin
Create a new file in `lua/plugins/` or add to an existing one:
```lua
return {
  'username/plugin-name',
  opts = {
    -- plugin options
  },
}
```

### Configure Existing Plugins
Find the plugin in `lua/plugins/` and modify its `opts` or `config` function.

## Plugin Categories

### Editor Enhancements (editor.lua)
- **gitsigns** - Git changes in the gutter
- **todo-comments** - Highlight TODO/FIXME comments
- **persistence** - Session management
- **overseer** - Task runner

### Navigation (navigation.lua)
- **hop.nvim** - Jump anywhere with few keystrokes
  - `f/F` - Jump to character on line
  - `<leader>j/k` - Jump to any line
  - `<leader>w` - Jump to any word

### UI Improvements (ui.lua)
- **which-key** - Shows available key bindings
- **mini.nvim** - Text objects and statusline
- **snacks.nvim** - Modern UI components, file explorer, pickers

### LSP (lsp.lua)
- **Language Servers** - Code intelligence for different languages
  - Angular (`angularls`) - Now properly configured with TypeScript
  - Lua (`lua_ls`)
  - C# (`csharp_ls`)
- **lspsaga** - Better LSP UI

### Completion (completion.lua)
- **blink.cmp** - Modern completion engine
- **nvim-cmp** - Alternative completion (backup)
- **LuaSnip** - Snippet engine

### Formatting (formatting.lua)
- **conform.nvim** - Automatic code formatting
  - Formats on save (configurable per language)
  - `<leader>f` - Format current buffer

### Telescope (telescope.lua)
- Fuzzy finder for files, text, and more
- `<leader>sf` - Find files
- `<leader>sg` - Search text (grep)
- `<leader>sh` - Search help

### Treesitter (treesitter.lua)
- Advanced syntax highlighting
- Automatically installs language parsers

## Fixing the Angular LSP

The Angular Language Server configuration has been fixed:

1. **TypeScript Detection** - Now checks both `/opt/homebrew` and `/usr/local` for TypeScript
2. **Project node_modules** - Looks for TypeScript in your project first
3. **Multiple Probe Locations** - Provides fallback paths for Angular to find dependencies

The error you saw was because Angular LSP couldn't find TypeScript. The new configuration:
- Sets `TSSERVER_PATH` environment variable
- Passes multiple `--tsProbeLocations` to the Angular server
- Checks your project's `node_modules` first, then global locations

## Common Tasks

### Installing Plugins
1. Add plugin to a file in `lua/plugins/`
2. Restart Neovim or run `:Lazy sync`

### Updating Plugins
Run `:Lazy update`

### Checking Plugin Status
Run `:Lazy`

### Installing Language Servers
Run `:Mason` to see available language servers

### Checking Health
Run `:checkhealth` to diagnose issues

## Key Bindings Reference

### Window Navigation
- `Ctrl+h/j/k/l` - Move between windows

### File Operations
- `<leader>sf` - Find files
- `<leader>sg` - Search text
- `<leader>e` - File explorer

### LSP
- `gd` - Go to definition
- `gr` - Find references
- `grn` - Rename symbol
- `<leader>ca` - Code actions

### Git
- `<leader>gs` - Git status
- `<leader>gb` - Git branches
- `<leader>gg` - Lazygit

### Other
- `<leader>f` - Format file
- `<Esc>` - Clear search highlighting

## Tips for Non-Lua Experts

### Understanding `return` statements
Each plugin file returns a table (like an object/dictionary):
```lua
return {
  'plugin-name',  -- This is the plugin to install
  opts = { ... }, -- These are options passed to the plugin
}
```

### Understanding `require()`
`require('core.options')` loads the file at `lua/core/options.lua`

### Understanding Functions
```lua
function()
  -- code here
end
```
This is an anonymous function (like a lambda in other languages)

### Understanding Tables
```lua
local my_table = {
  key1 = 'value1',
  key2 = 'value2',
}
```
Tables are like objects/dictionaries

### Understanding Keymaps
```lua
vim.keymap.set('n', '<leader>w', '<cmd>write<CR>', { desc = 'Save' })
```
- `'n'` = normal mode
- `<leader>w` = Space then w
- `<cmd>write<CR>` = Run the write command
- `{ desc = 'Save' }` = Description shown in which-key

## Troubleshooting

### Plugins not loading
1. Run `:Lazy sync`
2. Check for errors with `:messages`

### LSP not working
1. Run `:LspInfo` to see active servers
2. Run `:Mason` to install language servers
3. Check `:checkhealth`

### Angular LSP still failing
1. Verify TypeScript is installed: `npm list -g typescript`
2. If not: `npm install -g typescript`
3. Check the path matches in `lua/plugins/lsp.lua`

### Starting fresh
Delete `~/.local/share/nvim` and restart Neovim to reinstall everything
