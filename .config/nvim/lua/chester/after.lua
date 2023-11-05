-- Colorscheme
vim.cmd.colorscheme('carbonfox')
--
-- Transparent plugin
-- vim.g.transparent_groups = vim.list_extend(
--   vim.g.transparent_groups or {},
--   vim.tbl_map(function(v)
--     return v.hl_group
--   end, vim.tbl_values(require("bufferline.config").highlights))
-- )


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
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local tree_wins = {}
    local floating_wins = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
        table.insert(tree_wins, w)
      end
      if vim.api.nvim_win_get_config(w).relative ~= '' then
        table.insert(floating_wins, w)
      end
    end
    if 1 == #wins - #floating_wins - #tree_wins then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(tree_wins) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end
})

if vim.g.transparent_enabled then
  require('transparent').clear_prefix('lualine')
end
