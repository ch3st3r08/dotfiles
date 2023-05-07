return {
  -- Shared Utils
  { "nvim-lua/plenary.nvim",         lazy = true },
  { "nvim-tree/nvim-web-devicons",   lazy = true },
  { "onsails/lspkind-nvim" }, -- Vscode-like pictograms to LSP

  -- Diagnostic
  { "folke/trouble.nvim",            config = true },

  -- Terminal Helper
  { 'akinsho/toggleterm.nvim',       version = "*", config = true },

  -- Git integration
  { "lewis6991/gitsigns.nvim",       config = true },
  { "tpope/vim-fugitive" },

  -- Tmux interop
  { "christoomey/vim-tmux-navigator" },

  -- Session plugins
  { "tpope/vim-obsession",           enabled = false },

  -- Misc
  { "folke/zen-mode.nvim",           config = true },
  { "folke/twilight.nvim",           config = true },
  {
    'Wansmer/treesj',
    keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = true
  },
  {
    "folke/which-key.nvim",
    lazy = true,
    opts = {
      triggers_blacklist = {
        i = { "<space>" },
      }
    }
  },
  { "mhinz/vim-startify",     enabled = false },
  { "cseelus/vim-colors-tone" },
  {
    "xiyaowong/transparent.nvim",
    opts = {
      extra_groups = {
        "NormalFloat",
        "NvimTreeNormal",
        "NvimTreeNormalNC"
      }
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      show_end_of_line = true
    }
  },
  { 'echasnovski/mini.comment',     main = "mini.comment",   config = true },
  { 'echasnovski/mini.pairs',       main = "mini.pairs",     config = true },
  { 'echasnovski/mini.surround',    main = "mini.surround",  config = true },
  { 'echasnovski/mini.bufremove',   main = "mini.bufremove", config = true },
  { 'echasnovski/mini.sessions',    main = "mini.sessions",  config = true },
  { "editorconfig/editorconfig-vim" },
}
