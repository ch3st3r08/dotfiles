return {
  {
    enabled = true,
    "nvim-lualine/lualine.nvim",
    config = function()
      local custom_auto = require 'lualine.themes.tokyonight'
      custom_auto.normal.c.bg = 'NONE'

      require 'lualine'.setup({
        options = {
          theme = 'auto',
          icons_enabled = true,
          disabled_filetypes = {
            winbar = { "NvimTree", "startify" },
            statusline = { "NvimTree", "startify", "starter" }
          },
          --globalstatus = true,
        },
        tabline = {
          lualine_a = {'buffers'},
          lualine_b = {'branch'},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {'tabs'}
        },
        extensions = {
          'quickfix', 'trouble', 'nvim-tree', 'lazy'
        },
      })
    end
  },
}

