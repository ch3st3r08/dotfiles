local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = true,
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

local cmp = require('cmp')
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
      { name = 'path' },
      { name = 'nvim_lsp' },
      { name = 'buffer',  keyword_length = 3 },
      { name = 'luasnip', keyword_length = 2 },
  },
  formatting = {
    format = require("lspkind").cmp_format({
      mode = 'symbol_text',
      maxwidth = 70,
      ellipsys_char = '...',
      menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
      })
    })
  }
})
