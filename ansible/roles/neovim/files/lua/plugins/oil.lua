return {
  {
    "stevearc/oil.nvim",
    opts = {
      delete_to_trash = false,
    },
    keys = { { "<leader>e", "<cmd>Oil<cr>", desc = "Open Oil" } },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
}
