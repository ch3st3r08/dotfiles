local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

require'lualine'.setup({
  options = {
    theme = 'nord',
    icons_enabled = true,
    disabled_filetypes = {
      winbar = {"NvimTree","startify"}
    },
    globalstatus = true,
  },
  sections = {
    lualine_b = {
      {'b:gitsigns_head', icon = ''},
      {'diff', source = diff_source},
      'diagnostics'
    }
  },
  -- tabline = {
  --   lualine_a = {
  --     {
  --       'buffers',
  --       show_modified_status = true,
  --     }
  --   },
  --   lualine_z = {'tabs'},
  -- },
  -- winbar = {
  --   lualine_z = {'%F'}
  -- },
  extensions = {'nvim-tree','fugitive'}
})
