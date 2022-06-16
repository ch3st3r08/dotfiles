local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

local function get_setup(name)
  return string.format('require("chester/setup/%s")', name)
end

-- Source and Compile on save
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local packer = require("packer")

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float {border = "rounded"}
    end
  }
}

return packer.startup(function(use)

  --Packer manages itself
  use "wbthomason/packer.nvim"
  use "nvim-lua/plenary.nvim" --Bunch of usefull functions for lua
  use "nvim-lua/popup.nvim" -- An implementation of vim popup api [WIP]

  --Icons
  use "kyazdani42/nvim-web-devicons"

  --LSP Stuff
  use({
    "neovim/nvim-lspconfig",
    config = get_setup("lsp")
  })
  use "williamboman/nvim-lsp-installer" -- Installing lsp servers easily
  use "onsails/lspkind-nvim" -- Vscode-like pictograms to LSP

  use {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
    end
  }

  --Treesitter stuff
  use({
    "nvim-treesitter/nvim-treesitter",
    config = get_setup("treesitter"),
    run = ":TSUpdate"
  })
  use "nvim-treesitter/nvim-treesitter-textobjects"

  --Syntax, Autocompletion and Snippets
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      {"hrsh7th/cmp-nvim-lsp"},
      {"hrsh7th/cmp-buffer"},
      {"hrsh7th/cmp-path"},
      {"hrsh7th/cmp-cmdline"},
      {"saadparwaiz1/cmp_luasnip"},
      {"L3MON4D3/LuaSnip", config = get_setup("luasnip")}
    },
    config = get_setup("cmp")
  })

  --File Browser Lua
  use {
    "kyazdani42/nvim-tree.lua",
    config = get_setup("nvim-tree")
  }

  --Fuzzy Finder and more
  use {
    "nvim-telescope/telescope.nvim",
    config = get_setup("telescope")
  }

  --StatusLine
  use {"nvim-lualine/lualine.nvim", config = get_setup("lualine")}

  -- Colors Schemes
  use "cseelus/vim-colors-tone"
  use "Matsuuu/pinkmare"
  use {"folke/tokyonight.nvim", branch = 'main'}
  use "marko-cerovac/material.nvim"
  use "gruvbox-community/gruvbox"
  use {"shaunsingh/nord.nvim", as ="nord2"}
  use {"dracula/vim", as = "dracula"}
  use "Th3Whit3Wolf/one-nvim"
  use "cocopon/iceberg.vim"
  use "hachy/eva01.vim"
  use "raphamorim/lucario"
  use "sainnhe/edge"
  use "rafamadriz/neon"
  use 'EdenEast/nightfox.nvim'
  use "sainnhe/sonokai"
  use { 'AlphaTechnolog/pywal.nvim', as = 'pywal' }

  --Terminal Utilities
  use "kassio/neoterm"

  --Utils
  use "mhinz/vim-startify"
  use ({
    "windwp/nvim-autopairs",
    config = get_setup("nvim-autopairs")
  })
  use "alvan/vim-closetag"
  use "moll/vim-bbye"
  use "ap/vim-css-color"
  use "chrisbra/Colorizer"
  use "liuchengxu/vim-which-key"
  use "tpope/vim-surround"
  use "rafamadriz/friendly-snippets"
  use {
    "iamcco/markdown-preview.nvim",
    run = 'cd app && npm install',
    cmd = 'MarkdownPreview'
  }
  use "junegunn/goyo.vim"
  use "sotte/presenting.vim"
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  }
  use "editorconfig/editorconfig-vim"
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

