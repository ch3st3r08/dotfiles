return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local custom_auto = require 'lualine.themes.auto'
      custom_auto.normal.c.bg = 'NONE'

      require 'lualine'.setup({
        options = {
          theme = "auto",
          icons_enabled = true,
          disabled_filetypes = {
            winbar = { "NvimTree", "startify" },
            statusline = { "NvimTree", "startify", "starter" }
          },
          --globalstatus = true,
        },
      })
    end
  },
}

