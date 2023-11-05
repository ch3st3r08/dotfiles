return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim',          build = ':MasonUpdate' },
      { 'williamboman/mason-lspconfig.nvim' },
      -- Completion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'L3MON4D3/LuaSnip',                 dependencies = { 'rafamadriz/friendly-snippets' } },
    },
    config = function()
      local lsp = require('lsp-zero').preset({
        name = 'recommended',
      })
      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({buffer = bufnr})
      end)
      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

      lsp.setup()

      local cmp = require('cmp')
      local cmp_action = require('lsp-zero').cmp_action()
      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup({
        sources = {
          { name = 'path' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'buffer',  keyword_length = 3 },
          { name = 'luasnip', keyword_length = 2 },
        },
        mapping = {
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward()
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
    end
  },
}
