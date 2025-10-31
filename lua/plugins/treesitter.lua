-- Treesitter
-- Advanced syntax highlighting and code understanding

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    -- Languages to install
    ensure_installed = {
      'angular',
      'bash',
      'c',
      'c_sharp',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
    },
    -- Auto-install missing parsers when opening a file
    auto_install = true,
    -- Enable syntax highlighting
    highlight = {
      enable = true,
      -- Some languages need vim's regex highlighting for indentation
      additional_vim_regex_highlighting = { 'ruby' },
    },
    -- Enable smart indentation
    indent = {
      enable = true,
      disable = { 'ruby' },
    },
  },
}
