filetype off            "Helps force plug-ins to load correctly
syntax enable           "Enables syntax highlighting
set encoding=utf-8      "The encoding displayed
set fileencoding=utf-8      "The encoding written to file
filetype plugin indent on
set hidden          "Required to keep multiple buffers open
set nowrap          "Display long lines as just one line
set pumheight=10        "Makes opoup menu smaller
set list        "Shows non-printable charaacters
set listchars=tab:\|\ ,trail:⋅,nbsp:⎵
set ruler           "Show the cursor position all the time
set cmdheight=2         "More space for displaying messages
set iskeyword+=-        "Treat dash separated words as a word text object
set mouse=a         "Enable your mouse
set splitbelow          "Horizontal splits will automatically be below
set splitright          "Vertical splits will automatically be to the right
set conceallevel=0      "So that I can ´´ in markdown files
set tabstop=4
set softtabstop=-1      "Insert 2 spaces for a tab
set shiftwidth=0        "Change the number of space chars inserted for indentation
set autoindent          "Good auto indent
set smarttab            "Makes tabbing smarter
set smartindent
set expandtab           "Converts tabs to spaces
set laststatus=0        "Always display the status line
set relativenumber          "Line numbers
set number
set nohlsearch
set cursorline          "Enable hightlightning of the cursor line
set showtabline=2       "Always show tabs
set noshowmode          "We don't need to see thigns like --INSERT --anymore
set nobackup            "Recommended by CoC
set noswapfile
set incsearch
set scrolloff=2
set nowritebackup       "Recommended by CoC
set updatetime=300      "Faster completion
set timeoutlen=500      "By default timeoutlen is 1000ms
set formatoptions-=cro      "Stop newline continution comments
set clipboard=unnamedplus   "Copy paste between vim and everything else
set completeopt=menu,menuone,noinsert,noselect
set signcolumn=yes
set termguicolors

let g:mapleader = "\<Space>"

"Check if Vimplug is installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
     silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
       autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')
"#####Colors Schemes
"Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'marko-cerovac/material.nvim'
Plug 'gruvbox-community/gruvbox'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
"Plug 'arcticicestudio/nord-vim'
"Plug 'sonph/onehalf', { 'rtp': 'vim' }
"Plug 'RRethy/nvim-base16'
"Plug 'rakr/vim-one'
Plug 'Th3Whit3Wolf/one-nvim'
Plug 'cocopon/iceberg.vim'
Plug 'hachy/eva01.vim'
Plug 'cseelus/vim-colors-tone'
Plug 'Matsuuu/pinkmare'
Plug 'raphamorim/lucario'
Plug 'dracula/vim', {'as':'dracula'}
Plug 'sainnhe/edge'
Plug 'shaunsingh/nord.nvim', {'as':'nord2'}

"#####Utils
Plug 'windwp/nvim-autopairs'
"Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'moll/vim-bbye'
Plug 'ap/vim-css-color'
Plug 'mhinz/vim-startify'
Plug 'liuchengxu/vim-which-key'
Plug 'tpope/vim-surround'
"#####Icons
"Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
"#####Syntax, Autocompletion and Snippets
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'williamboman/nvim-lsp-installer'
" #####Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" #####Fuzzy finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
"#####StatusLine
Plug 'nvim-lualine/lualine.nvim'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"#####File Browser"
"Plug 'preservim/nerdtree'
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

"#####File Browser Lua
Plug 'kyazdani42/nvim-tree.lua'

"#####Terminal utilities
Plug 'kassio/neoterm'
call plug#end()


"lua vim.lsp.set_log_level("debug")

lua <<EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = {noremap=true, silent=true}
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {}
    opts.on_attach = on_attach
    opts.capabilities = capabilities
    server:setup(opts)
end)

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require 'luasnip'
local cmp = require 'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
            },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },{
        { name = 'buffer' },
    }),
})
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})
-- You can also use lazy loading so you only get in memory snippets of languages you use
require("luasnip/loaders/from_vscode").lazy_load()
EOF



"Vim airline config options
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

"Enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme='nord'

"Nerdtree options
"let NERDTreeMinimalUI=1
"let NERDTreeDirArrows=1
"let NERDTreeShowHidden=1
"nnoremap <C-n> :NERDTreeToggle<CR>

"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif
" Exit Vim if NERDTree is the only window left.
"autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
"    \ quit | endif

"Telescope options
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

""nvim-tree options
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

highlight NvimTreeFolderIcon guibg=blue
let g:nvim_tree_gitignore = 1 "0 by default
let g:nvim_tree_quit_on_open = 0 "0 by default, closes the tree when you open a file
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
let g:nvim_tree_create_in_closed_folder = 0 "1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
let g:nvim_tree_refresh_wait = 500 "1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'notify',
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }

lua <<EOF
    require'nvim-tree'.setup{}
EOF


lua <<EOF
    require'lualine'.setup({
        options = {
            theme = 'auto',
            icons_enabled = true,
        },
        tabline = {
            lualine_a = {
                {
                    'buffers',
                    show_modified_status = true,
                }
            },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {'tabs'},
        },
        extensions = {'nvim-tree'}
    })
EOF

lua <<EOF
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
    require('nvim-autopairs').setup{}
EOF

lua <<EOF
    require'nvim-treesitter.configs'.setup {
      highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      indent = {
          enable = true,
      },
    }
EOF

"darker lighter oceanic palenight deep ocean
let g:material_style = 'deep'

"storm, night and day.
let g:tokyonight_style = "storm"
colorscheme iceberg

"To keep terminal trnasparency
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
"hi NvimTreeNormal guibg=NONE ctermbg=NONE

"autocmd Colorscheme * highlight NvimTreeNormal guibg=NONE
"Vim-closetag options
let g:closetag_filenames = '*.vue,*.html,*.xhtml,*.phtml'
let g:closetag_filetypes = 'vue,html,xhtml,phtml'

"Set format options when opening new files
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
"CoC options
"source $HOME/.config/nvim/plug-config/coc.vim

"Prettier options
"command! -nargs=0 Prettier :CocCommand prettier.formatFile
"Funcionará hasta tener la version 0.5 de neovim
"source $HOME/.config/nvim/plug-config/nvim-tree.vim

"Startify options
let g:startify_lists = [
         \ { 'header': ['  Files'], 'type': 'files' },
         \ { 'header': ['  Current Directory '. getcwd()] },
         \ { 'header': ['  Bookmars'], 'type': 'bookmarks' },
         \]

let g:startify_bookmarks = [
         \ { 'b': '~/.bashrc' },
         \ { 'v': '~/.config/nvim/init.vim' },
         \]

let g:startify_fortune_use_unicode = 1


"Mis remapeos 
"Guardar archivo
nnoremap <leader>w :w<CR>
inoremap <leader>w <ESC>:w<CR>
"Salir del modo terminal de neoVim
tnoremap <leader><Esc> <C-\><C-n>

"Abrir mi configuracion de NEOVIM
nnoremap <leader>ee :e $MYVIMRC<CR>

"Deshabilitar flechas de direccion
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>


"Cambiar tamaño de ventanas usando flechas
nnoremap <silent> <right> :vertical resize +5<CR>
nnoremap <silent> <left> :vertical resize -5<CR>
nnoremap <silent> <up> :resize +5<CR>
nnoremap <silent> <down> :resize -5<CR>

"Moverse entre buffers
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

"Abrir terminal"
"vnoremap <c-t> :split<CR>:terminal<CR>:resize 8<CR>
"nnoremap <c-t> :split<CR>:terminal<CR>:resize 8<CR>

"Abrir terminal Neoterm
vnoremap <c-t> :8split<CR>:Topen<CR>:setl nobuflisted<CR>:redrawt<CR>
nnoremap <c-t> :8split<CR>:Topen<CR>:setl nobuflisted<CR>:redrawt<CR>

tnoremap <leader>x <C-\><C-n>:Tclose!<CR>
tnoremap <leader>q <C-\><C-n>:Tclose<CR>

"Cerrar buffers
nnoremap <leader>x :Bwipeout<CR>
vnoremap <leader>x :Bwipeout<CR>

"Vim vim-which-key maps
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
