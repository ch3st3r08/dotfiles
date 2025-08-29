vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
      runtime = { version = 'LuaJIT' },
      telemetry = { enable = false },
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
})
