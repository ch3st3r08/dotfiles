return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.hypr = {
        install_info = {
          url = "https://github.com/luckasRanarison/tree-sitter-hypr",
          files = { "src/parser.c" },
          branch = "master",
        },
        filetype = "hypr",
      }
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "bash", "javascript", "css", "html", "json", "python" },
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      }
    end
  },
  { "nvim-treesitter/nvim-treesitter-textobjects" },
}
