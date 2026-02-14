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
      'css',
      'diff',
      'html',
      'javascript',
      'jsdoc',
      'json',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
    },
    -- Auto-install missing parsers when opening a file
    auto_install = true,
    -- Enable syntax highlighting with error handling
    highlight = {
      enable = true,
      -- Some languages need vim's regex highlighting for indentation
      additional_vim_regex_highlighting = { 'ruby' },
      -- Disable treesitter highlighting for very large files to prevent performance issues
      disable = function(lang, buf)
        if lang == 'latex' then
          return true
        end
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    -- Enable smart indentation
    indent = {
      enable = true,
      disable = { 'ruby', 'latex' },
    },
    -- Enable embedded language highlighting (for Angular templates)
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  },

}
