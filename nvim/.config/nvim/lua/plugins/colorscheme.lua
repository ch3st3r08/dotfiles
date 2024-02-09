return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "duskfox",
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    config = function()
      require("nordic").setup({
        bold_keywords = false,
        italic_comments = false,
        transparent_bg = true,
      })
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
        },
      })
    end,
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
