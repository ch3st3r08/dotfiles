return {
  {
    enabled = false,
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup({
        options = {
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
            }
          },
          close_command = "lua MiniBufremove.wipeout(%d)",
          diagnostics = "nvim_lsp",
        }
      })
    end
  },
}
