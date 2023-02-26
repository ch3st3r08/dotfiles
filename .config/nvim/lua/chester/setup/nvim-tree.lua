require'nvim-tree'.setup{
  view = {
    side = 'left', width = 30,
    mappings = {
      list = {
        {key = "<C-l>", action = "cd"}
      }
    }
  },
  respect_buf_cwd = false,
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    highlight_opened_files = "none",
  }
}
