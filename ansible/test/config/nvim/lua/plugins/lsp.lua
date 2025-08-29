return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
    servers = {
      pylsp = {
        plugins = {
          pydocstyle = {
            enabled = true,
            convention = "google",
          },
          mypy = {
            enabled = true,
            live_mode = true,
          },
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.lsp.signature = {
        opts = { size = { max_height = 5 } },
      }
    end,
  },
}
