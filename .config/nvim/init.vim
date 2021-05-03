let g:mapleader = "\<Space>"

filetype off            "Helps force plug-ins to load correctly
syntax enable           "Enables syntax highlighting
filetype plugin indent on
set hidden          "Required to keep multiple buffers open
set nowrap          "Display long lines as just one line
set encoding=utf-8      "The encoding displayed
set pumheight=10        "Makes opoup menu smaller
set list        "Shows non-printable charaacters
set listchars=tab:\|\ ,trail:⋅,nbsp:⎵,eol:¬
set fileencoding=utf-8      "The encoding written to file
set ruler           "Show the cursor position all the time
set cmdheight=2         "More space for displaying messages
set iskeyword+=-        "Treat dash separated words as a word text object
set mouse=a         "Enable your mouse
set splitbelow          "Horizontal splits will automatically be below
set splitright          "Vertical splits will automatically be to the right
set conceallevel=0      "So that I can ´´ in markdown files
set tabstop=3
set softtabstop=-1      "Insert 2 spaces for a tab
set shiftwidth=0        "Change the number of space chars inserted for indentation
set smarttab            "Makes tabbing smarter
set smartindent
set expandtab           "Converts tabs to spaces
set autoindent          "Good auto indent
set laststatus=0        "Always display the status line
set relativenumber          "Line numbers
set nu
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
set completeopt=menuone,noinsert,noselect
set signcolumn=yes
set termguicolors

"Check if Vimplug is installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
     silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
       autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
 endif

call plug#begin(stdpath('data') . '/plugged')
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'gruvbox-community/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'rakr/vim-one'
Plug 'cocopon/iceberg.vim'
Plug 'hachy/eva01.vim'
Plug 'cseelus/vim-colors-tone'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'moll/vim-bbye'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Funcionará hasta la version 0.5 de neovim
"Plug 'kyazdani42/nvim-web-devicons'
"Plug 'kyazdani42/nvim-tree.lua'
call plug#end()

let g:material_terminal_italics = 1
"let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
let g:material_theme_style = 'default'
colorscheme nord

"To keep terminal trnasparency
"hi Normal guibg=NONE ctermbg=NONE
"hi LineNr guibg=NONE ctermbg=NONE
"hi SignColumn guibg=NONE ctermbg=NONE
"hi EndOfBuffer guibg=NONE ctermbg=NONE

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
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeShowHidden=1
nnoremap <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

"Vim-closetag options
let g:closetag_filenames = '*.vue,*.html,*.xhtml,*.phtml'
let g:closetag_filetypes = 'vue,html,xhtml,phtml'

"Set format options when opening new files
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro


"CoC options
source $HOME/.config/nvim/plug-config/coc.vim

"Prettier options
command! -nargs=0 Prettier :CocCommand prettier.formatFile
"Funcionará hasta tener la version 0.5 de neovim
"source $HOME/.config/nvim/plug-config/nvim-tree.vim

"Mis remapeos 
"Salir del modo terminal de neoVim
tnoremap <leader><Esc> <C-\><C-n>

"Abrir mi configuracion de NEOVIM
nnoremap <leader>e :e $MYVIMRC<CR>

"Remap keys for range format
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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
nnoremap <leader>l :bn<CR>
nnoremap <leader>h :bp<CR>

"Abrir terminal"
vnoremap <c-t> :split<CR>:terminal<CR>:resize 8<CR>
nnoremap <c-t> :split<CR>:terminal<CR>:resize 8<CR>

