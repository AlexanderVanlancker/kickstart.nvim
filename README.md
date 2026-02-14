# Neovim Configuration

A Neovim configuration using lazy.nvim (no Mason required).

## Requirements

- Neovim >= 0.11.0
- .NET SDK installed
- ripgrep, fd-find, git, make, unzip

## Roslyn LSP Setup (C#/.NET)

This section documents how to set up the Roslyn language server for C# development.

### 1. Install the Plugin

Add to your lazy.nvim config:

```lua
{
  'seblyng/roslyn.nvim',
  ft = 'cs',
  opts = {},
}
```

### 2. Download Roslyn

Download the Roslyn language server for your platform:

- **macOS (Intel)**: `osx-x64`
- **macOS (Apple Silicon)**: `osx-arm64`
- **Linux**: `linux-x64`
- **Windows**: `win-x64`

Download URL:
```
https://dev.azure.com/azure-public/vside/_artifacts/feed/vs-impl/NuGet/Microsoft.CodeAnalysis.LanguageServer.<platform>/overview
```

### 3. Extract and Install

```bash
# Create roslyn directory
mkdir -p ~/.local/share/nvim/roslyn

# Extract the nupkg (it's a zip file)
unzip Microsoft.CodeAnalysis.LanguageServer.osx-arm64.x.x.x.nupkg -d ~/.local/share/nvim/roslyn
```

### 4. Create Wrapper Script

Create `~/.local/bin/roslyn` (ensure `~/.local/bin` is in your PATH):

```bash
#!/bin/bash
exec "/Users/personal/.local/share/nvim/roslyn/content/LanguageServer/osx-arm64/Microsoft.CodeAnalysis.LanguageServer" "$@"
```

```bash
chmod +x ~/.local/bin/roslyn
```

### 5. Remove Quarantine (macOS)

If macOS blocks the executable:

```bash
xattr -rd com.apple.quarantine ~/.local/share/nvim/roslyn/content/LanguageServer/osx-arm64/Microsoft.CodeAnalysis.LanguageServer
```

### 6. Verify

```bash
roslyn --help
```

### 7. Restart Neovim

Open a .cs file and the LSP should attach automatically.

---

## Plugin List

- **lazydev.nvim** - Lua LSP configuration
- **fidget.nvim** - LSP status updates
- **blink.cmp** - Completion
- **telescope.nvim** - Fuzzy finder
- **treesitter** - Syntax highlighting
- **nvim-surround** - Surround selections
- **gitsigns.nvim** - Git integration
- **snacks.nvim** - UI enhancements
- **roslyn.nvim** - C# LSP
