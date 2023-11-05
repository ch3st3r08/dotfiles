return {
  { "mhartington/oceanic-next" },
  {
    "folke/tokyonight.nvim",
    priority = 1001,
    lazy = false,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  { "cocopon/iceberg.vim" },
  { "sainnhe/edge" },
  { "edeneast/nightfox.nvim" },
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_disable_background = true
      vim.g.nord_italic = false
      vim.g.nord_bold = false
      vim.g.nord_borders = true
    end,
  },
}
