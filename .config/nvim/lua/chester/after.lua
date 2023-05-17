-- Colorscheme
vim.cmd.colorscheme('tokyonight')
--
-- Transparent plugin
vim.g.transparent_groups = vim.list_extend(
  vim.g.transparent_groups or {},
  vim.tbl_map(function(v)
    return v.hl_group
  end, vim.tbl_values(require("bufferline.config").highlights))
)


-- Algunos comandos
vim.api.nvim_create_user_command('SSave',
  function(opts)
    MiniSessions.write(opts.fargs[1])
  end, { nargs = '?' }
)

-- Cerrar todos los buffers menos el actual
vim.api.nvim_create_user_command('Bc',
  function()
    vim.cmd('%bd|e#|bd#')
  end, { nargs = '?' }
)
