# Using Neovim Config with Nix

This Neovim configuration can be run using Nix, which ensures all dependencies are properly installed and available.

## Prerequisites

- [Nix package manager](https://nixos.org/download.html) installed with flakes enabled
- To enable flakes, add this to `~/.config/nix/nix.conf`:
  ```
  experimental-features = nix-command flakes
  ```

## Quick Start

### Option 1: Development Shell (Recommended)

Enter a development shell with all dependencies:

```bash
nix develop
```

This gives you access to:
- `nvim` - Neovim editor
- `rg` - ripgrep (fast search)
- `fd` - fast find alternative
- `node` - Node.js LTS (v22)
- `npm` - Node package manager
- Additional tools: git, gcc, make, lazygit, etc.

Once in the shell, simply run:
```bash
nvim
```

### Option 2: direnv Integration (Automatic)

If you have [direnv](https://direnv.net/) installed:

1. Allow direnv for this directory:
   ```bash
   direnv allow
   ```

2. The development environment will automatically activate when you `cd` into this directory

3. Just run `nvim` as normal

## What's Included

The Nix configuration provides:

### Core Dependencies
- **Neovim** - Latest version
- **ripgrep** (`rg`) - Required by Telescope for fast file searching
- **fd** - Required by Telescope for fast file finding
- **Node.js v22** (LTS) - Required by many LSP servers and plugins

### LSP Servers (Managed by Nix, no Mason!)
- **lua-language-server** - Lua LSP for Neovim configuration
- **typescript-language-server** - TypeScript/JavaScript LSP (handles go-to-definition for imports)

### LSP Servers (Install via package managers)
Some LSP servers aren't available in nixpkgs for Apple Silicon:
- **Angular Language Server** - For Angular templates - Install via npm: `npm install -g @angular/language-server`
- **C# Language Server** - Install via dotnet: `dotnet tool install -g csharp-ls`

### Formatters
- **stylua** - Lua code formatter (provided by Nix)
- **csharpier** - C# formatter - Install via: `dotnet tool install -g csharpier`

### Development Tools
- **git** - Version control
- **gcc** - C compiler (required by Treesitter for parser compilation)
- **make** - Build tool
- **lazygit** - Terminal UI for git (optional, used by lazygit.nvim)
- **tree-sitter** - Parser generator tool

## First Time Setup

When you first run Neovim with this config:

1. **Plugin Installation**: Lazy.nvim will automatically install all plugins on first launch
2. **Treesitter Parsers**: Run `:TSUpdate` to install syntax parsers
3. **LSP Servers**: All LSP servers are provided by Nix - no manual installation needed!

## Updating Dependencies

To update Nix dependencies:

```bash
nix flake update
```

To update Neovim plugins, open Neovim and run:
```
:Lazy update
```

## Troubleshooting

### Flakes not enabled
If you get an error about flakes, ensure you have this in `~/.config/nix/nix.conf`:
```
experimental-features = nix-command flakes
```

### Plugin issues
If plugins don't load correctly, try:
1. Remove lazy-lock.json: `rm lazy-lock.json`
2. Clear plugin cache: `rm -rf ~/.local/share/nvim`
3. Restart Neovim

### LSP servers not working
All LSP servers are provided by Nix. If an LSP isn't working:
1. Make sure you're in the Nix shell: `nix develop`
2. Check the server is in PATH: `which lua-language-server`
3. Check Neovim can see it: `:LspInfo` in Neovim

To add a new LSP server, edit `flake.nix` and add it to the `devDependencies` list.

## Customizing the Nix Config

### Adding More LSP Servers

Edit `flake.nix` and add to the `devDependencies` list. Common LSP servers available in nixpkgs:

```nix
# Python
pyright
# or
python3Packages.python-lsp-server

# TypeScript/JavaScript
nodePackages.typescript-language-server

# Go
gopls

# Rust
rust-analyzer

# HTML/CSS/JSON
nodePackages.vscode-langservers-extracted

# YAML
yaml-language-server

# Nix
nil  # or nixd
```

Then add the server configuration to `lua/plugins/lsp.lua` in the `servers` table.

### Adding More Formatters

Similarly, add formatters to `devDependencies`:

```nix
# JavaScript/TypeScript
nodePackages.prettier

# Python
black
isort

# Go
gofmt  # or gofumpt
```

Then configure them in `lua/plugins/formatting.lua`.

### Other Customizations

- Change Node.js version (e.g., `nodejs_20` for v20)
- Add additional system dependencies
- Modify the Neovim wrapper configuration

After editing, the changes take effect immediately with `nix develop` or `nix run .#nvim`.

## Using Outside This Directory

To use this config from anywhere:

```bash
# Run from the config directory path
nix run ~/.config/nvim#nvim

# Or add to your flake.nix inputs:
inputs.my-nvim.url = "path:/Users/Alexander/.config/nvim";
```

## Integration with System Neovim

This Nix setup is independent of your system Neovim installation. You can:
- Keep your system Neovim and this Nix version separate
- Test changes in the Nix version before applying to your main config
- Use different configs for different projects

## Additional Resources

- [Lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager documentation
- [Mason.nvim](https://github.com/williamboman/mason.nvim) - LSP installer documentation
- [Nix Flakes](https://nixos.wiki/wiki/Flakes) - Nix flakes documentation
- Main config guide: See `CONFIG_GUIDE.md`
