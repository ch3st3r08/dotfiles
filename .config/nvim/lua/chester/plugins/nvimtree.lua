return {
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        view = {
          side = 'left', width = 30,
        },
        respect_buf_cwd = false,
        renderer = {
          add_trailing = false,
          group_empty = false,
          highlight_git = false,
          highlight_opened_files = "none",
        }
      })
    end
  },
}
