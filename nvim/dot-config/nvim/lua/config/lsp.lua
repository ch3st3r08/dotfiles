vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      telemetry = { enable = false },
    }
  }
})
vim.lsp.config("pylsp", {
  cmd = {'pylsp'},
  settings = {
    pylsp = {
      plugins = {
        pydocstyle = {
          enabled = false,
          convention = "google",
        },
        pylsp_mypy = {
          enabled = true,
          live_mode = true
        }
      }
    }
  }
})
