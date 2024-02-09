return {
  {
    "RRethy/vim-illuminate",
    enabled = false,
  },
  {
    "rcarriga/nvim-notify",
    -- opts will be merged with the parent spec
    opts = { background_colour = "#000000" },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- change a keymap
      { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find Files" },
    },
  },
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup({
        disable_when_zoomed = true,
      })
    end,
    keys = {
      { "<c-h>", "<cmd>NvimTmuxNavigateLeft<cr>", desc = "Navigate Left" },
      { "<c-j>", "<cmd>NvimTmuxNavigateDown<cr>", desc = "Navigate Down" },
      { "<c-k>", "<cmd>NvimTmuxNavigateUp<cr>", desc = "Navigate Up" },
      { "<c-l>", "<cmd>NvimTmuxNavigateRight<cr>", desc = "Navigate Right" },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        user_default_options = {
          css_fn = true,
        },
      })
    end,
  },
}
