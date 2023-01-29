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
  use {
    'VonHeikemen/lsp-zero.nvim',
    config = get_setup("lsp-zero"),
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }
  use "onsails/lspkind-nvim" -- Vscode-like pictograms to LSP

  use {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
    end
  }

  --Treesitter stuff
  use {
    "nvim-treesitter/nvim-treesitter",
    config = get_setup("treesitter"),
    run = ":TSUpdate"
  }
  use "nvim-treesitter/nvim-treesitter-textobjects"


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
  use {
    "nvim-lualine/lualine.nvim",
    config = get_setup("lualine")
  }
  use {
    "kdheepak/tabline.nvim",
    config = function ()
      require("tabline").setup({
        enable = false,
        show_tabs_always = true,
        show_bufnr = true,
        show_tabs_only = true
      })-- code
    end
  }
  use {
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup()
    end
  }
  -- Colors Schemes
  use "cseelus/vim-colors-tone"
  use "Matsuuu/pinkmare"
  use {"folke/tokyonight.nvim", branch = 'main'}
  use "marko-cerovac/material.nvim"
  use "gruvbox-community/gruvbox"
  use "shaunsingh/nord.nvim"
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
  use  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup()
    end
  }
  --Terminal Utilities
  use "kassio/neoterm"

  -- Git integration
  use "tpope/vim-fugitive"
  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  }
  --Utils
  use {
    "xiyaowong/nvim-transparent",
    config = function()
      require("transparent").setup({
        extra_groups = {
          "NvimTreeNormal"
        }
      })
    end
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        show_end_of_line = true
      })
    end
  }
  use {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup()
    end
  }
  use "mhinz/vim-startify"
  use {
    "windwp/nvim-autopairs",
    config = get_setup("nvim-autopairs")
  }
  use "alvan/vim-closetag"
  use "moll/vim-bbye"
  use "ap/vim-css-color"
  use "chrisbra/Colorizer"
  use "liuchengxu/vim-which-key"
  use "tpope/vim-surround"
  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  }
  use "junegunn/goyo.vim"
  use "sotte/presenting.vim"
  use "editorconfig/editorconfig-vim"
  use "christoomey/vim-tmux-navigator"

  -- Session plugins
  use "tpope/vim-obsession"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
