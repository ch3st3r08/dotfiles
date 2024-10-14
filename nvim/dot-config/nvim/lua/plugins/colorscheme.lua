return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "terafox",
    },
  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    opts = {
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = false,
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {
      transparent = false,
      -- styles = {
      --   sidebars = "transparent",
      --   floats = "transparent",
      -- },
    },
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    opts = {
      bold_keywords = false,
      italic_comments = false,
      transparent = false,
    },
  },
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        transparent = false,
      },
    },
  },
  {
    "neanias/everforest-nvim",
    version = false,
    config = function()
      require("everforest").setup({
        background = "medium",
        transparent_background_level = 1,
        italics = false,
        disable_italic_comments = true,
      })
    end,
  },
}
