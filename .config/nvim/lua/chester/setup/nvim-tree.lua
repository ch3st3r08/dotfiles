vim.cmd("highlight NvimTreeFolderIcon guibg=blue")
vim.g.nvim_tree_quit_on_open = 0 --"0 by default, closes the tree when you open a file
vim.g.nvim_tree_indent_markers = 1 --"0 by default, this option shows indent markers when folders are open
vim.g.nvim_tree_git_hl = 1 --"0 by default, will enable file highlight for git attributes (can be used without the icons).
vim.g.nvim_tree_highlight_opened_files = 1 --"0 by default, will enable folder and file icon highlight for opened files/directories.
vim.g.nvim_tree_root_folder_modifier = ':~' --"This is the default. See :help filename-modifiers for more options
vim.g.nvim_tree_add_trailing = 1 --"0 by default, append a trailing slash to folder names
vim.g.nvim_tree_group_empty = 1 --" 0 by default, compact folders that only contain a single folder into one node in the file tree
vim.g.nvim_tree_disable_window_picker = 1 --"0 by default, will disable the window picker.
vim.g.nvim_tree_icon_padding = ' ' --"one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
vim.g.nvim_tree_symlink_arrow = ' >> ' --" defaults to ' ➛ '. used as a separator between symlinks' source and target.
vim.g.nvim_tree_respect_buf_cwd = 1 --"0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
vim.g.nvim_tree_create_in_closed_folder = 0 --"1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
vim.g.nvim_tree_refresh_wait = 500 --"1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
vim.g.nvim_tree_window_picker_exclude = {
  filetype = {
    'notify',
    'packer',
    'qf'
  },
  buftype= {
    'terminal'
  }
}

require'nvim-tree'.setup{
  open_on_setup = true,
  ignore_ft_on_setup = {"startify"},
  auto_close = true,
  view = { side = 'left', width = 30, auto_resize = true},
}
