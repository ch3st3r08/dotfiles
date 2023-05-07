return {
  { "folke/tokyonight.nvim" },
  { "cocopon/iceberg.vim" },
  {
    "mhartington/oceanic-next",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme OceanicNext]])
    end,
  },
}
