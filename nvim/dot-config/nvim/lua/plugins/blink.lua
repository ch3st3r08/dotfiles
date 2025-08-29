return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },

  opts = {
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'default' },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      documentation = { auto_show = false },
      list = {
        selection = {
          preselect = false,
          auto_insert = false
        }
      }
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = { implementation = "lua" }
  },
  opts_extend = { "sources.default" }
}
