return {
  {
    "echasnovski/mini.icons",
    config = function()
      require('mini.icons').setup()
      MiniIcons.mock_nvim_web_devicons()
    end
  },

  {
    "echasnovski/mini.surround", version = '*', opts = {}
  },
  {
    'echasnovski/mini.comment', version = '*', opts = {}
  },
  {
    'echasnovski/mini.bufremove', version = '*', opts = {}
  },
  {
    'echasnovski/mini.pairs', version = '*', opts = {}
  },
  {
    'echasnovski/mini-git', version = '*', opts = {}, main = 'mini.git'
  },
  {
    'akinsho/toggleterm.nvim', version = "*", opts = {}
  },
  {
    'echasnovski/mini.statusline', version = '*', opts = {}
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    opts = {},
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    keys = {
      { "<leader>e", "<cmd>Oil<cr>", desc = "Open Oil" },
    },
    -- Optional dependencies
    dependencies = { "echasnovski/mini.icons" }
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
    opts = {}
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      user_default_options = {
        css = true,
        css_fn = true
      }
    },
  }
}
