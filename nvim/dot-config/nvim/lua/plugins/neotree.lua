return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {'<leader>fe', '<cmd>Neotree toggle<cr>', desc = 'Open NeoTree'}
    }
}
