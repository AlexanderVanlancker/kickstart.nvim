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

## .NET Core C# Debugging

This section documents how to set up debugging for .NET Core C# projects using nvim-dap.

### 1. Install netcoredbg

**macOS arm64 (Apple Silicon) - MUST BUILD FROM SOURCE:**

The official releases only include x86_64 binaries, which don't work properly with nvim-dap on Apple Silicon. You must compile from source:

```bash
# Prerequisites (if not already installed)
# brew install cmake ninja

# Clone and build
mkdir -p ~/.local/src
cd ~/.local/src
git clone --depth 1 https://github.com/Samsung/netcoredbg.git
cd netcoredbg
mkdir build && cd build
CC=clang CXX=clang++ cmake ..
make -j$(sysctl -n hw.ncpu)
sudo make install
```

This installs to `/usr/local/netcoredbg`.

**macOS Intel (x86_64) or Linux:**

Download the prebuilt binary:

```bash
# Download the debugger
curl -L -o ~/Downloads/netcoredbg.tar.gz "https://github.com/Samsung/netcoredbg/releases/download/3.1.3-1062/netcoredbg-osx-amd64.tar.gz"

# Extract to ~/.local/bin
tar -xzf ~/Downloads/netcoredbg.tar.gz -C ~/Downloads/
mkdir -p ~/.local/bin
cp ~/Downloads/netcoredbg/netcoredbg ~/.local/bin/
chmod +x ~/.local/bin/netcoredbg

# Verify
~/.local/bin/netcoredbg --version
```

### 2. Configure nvim-dap

The adapter is configured in `after/plugin/dap-cs.lua`. Update the path if needed:

```lua
M.netcoredbg_path = '/usr/local/netcoredbg'  -- macOS arm64 (built from source)
-- or
M.netcoredbg_path = '/Users/<username>/.local/bin/netcoredbg'  -- prebuilt
```

### 3. Restart Neovim

The dap plugins will be installed automatically via lazy.nvim.

### Keybindings

| Keybinding | Description |
|------------|-------------|
| `<leader>dc` | Start/continue debugging |
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dlp` | Log point (print to console) |
| `<leader>do` | Step over |
| `<leader>di` | Step into |
| `<leader>dO` | Step out |
| `<leader>dR` | Restart debugging |
| `<leader>dS` | Stop debugging |
| `<leader>du` | Toggle DAP UI |
| `<leader>dr` | Toggle REPL |
| `<leader>dj` | Move down in stack |
| `<leader>dk` | Move up in stack |
| `<leader>dll` | Launch .NET project (auto-detect DLL) |
| `<leader>dlr` | Run last debug configuration |
| `<leader>de` | Eval expression (normal/visual) |

### Running Debug

1. Open your .NET project in Neovim
2. Build your project: `dotnet build`
3. Press `<leader>dll` to auto-detect and launch your project, or `<leader>dc` for manual selection
4. The DAP UI will open showing breakpoints, variables, stack, and watch windows

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
- **nvim-dap** - Debug adapter protocol
- **nvim-dap-ui** - Debugging UI
