{
  description = "Neovim configuration with required dependencies";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Development shell with all dependencies
        devDependencies = with pkgs; [
          # Neovim and config dependencies
          neovim

          # Required tools
          ripgrep       # Fast search tool (required by Telescope)
          fd            # Fast find alternative (required by Telescope)
          nodejs_22     # Node.js LTS version

          # LSP servers
          lua-language-server                      # Lua LSP
          nodePackages.typescript-language-server  # TypeScript/JavaScript LSP
          # Note: C# LSP (csharp-ls) is not available on Apple Silicon
          # Use OmniSharp instead: dotnet tool install -g csharp-ls
          # Or use omnisharp-roslyn via Mason or direct install
          # Note: Angular language server (@angular/language-server) should be
          # installed via npm in your project: npm install -g @angular/language-server

          # Formatters
          stylua        # Lua formatter
          # Note: csharpier - install via: dotnet tool install -g csharpier

          # Additional useful tools for Neovim plugins
          git           # Version control
          gcc           # Compiler for Treesitter
          gnumake       # Build tool
          unzip         # Archive extraction
          curl          # Download tool

          # Optional but recommended
          lazygit       # TUI for git (if using lazygit.nvim)
          tree-sitter   # Parser generator tool
        ];

      in
      {
        # Development shell for working with this config
        devShells.default = pkgs.mkShell {
          buildInputs = devDependencies;

          shellHook = ''
            echo "Neovim development environment loaded!"
            echo ""
            echo "Available tools:"
            echo "  - nvim (Neovim editor)"
            echo "  - ripgrep (rg)"
            echo "  - fd"
            echo "  - node $(node --version)"
            echo "  - npm $(npm --version)"
            echo ""
            echo "LSP servers:"
            echo "  - lua-language-server"
            echo "  - typescript-language-server"
            echo ""
            echo "Install separately (not in nixpkgs for Apple Silicon):"
            echo "  - Angular: npm install -g @angular/language-server"
            echo "  - C#: dotnet tool install -g csharp-ls"
            echo ""
            echo "Formatters:"
            echo "  - stylua"
            echo "  - csharpier (install via: dotnet tool install -g csharpier)"
            echo ""
            echo "To use this config, simply run: nvim"
          '';
        };

        # Standalone Neovim package with dependencies
        packages.default = pkgs.writeShellScriptBin "nvim-with-deps" ''
          export PATH="${pkgs.lib.makeBinPath devDependencies}:$PATH"
          exec ${pkgs.neovim}/bin/nvim "$@"
        '';

        # Apps for 'nix run'
        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/nvim-with-deps";
        };
      }
    );
}
