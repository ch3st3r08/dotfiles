-- Transparent plugin
vim.g.transparent_groups = vim.list_extend(
  vim.g.transparent_groups or {},
  vim.tbl_map(function(v)
    return v.hl_group
  end, vim.tbl_values(require("bufferline.config").highlights))
)

-- Startify plugin
vim.g.startify_lists = {
  { header = { '  Bookmarks' },                             type = 'bookmarks' },
  { header = { '  Sessions' },                              type = 'sessions' },
  { header = { '  Files' },                                 type = 'files' },
  { header = { '  Current Directory ' .. vim.fn.getcwd() }, type = 'dir' },
}

vim.g.startify_bookmarks = {
  { b = '~/.config/zsh/.zshrc' },
  { v = '~/.config/nvim/init.lua' }
}

vim.g.startify_fortune_use_unicode = 1

-- Algunos comandos
vim.api.nvim_create_user_command('SSave',
  function(opts)
    MiniSessions.write(opts.fargs[1])
  end, { nargs = '?' }
)
