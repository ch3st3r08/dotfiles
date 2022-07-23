require'nvim-tree'.setup{
  open_on_setup = true,
  ignore_ft_on_setup = {"startify"},
  view = { side = 'left', width = 30},
  respect_buf_cwd = false,
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    highlight_opened_files = "none",
  }
}
