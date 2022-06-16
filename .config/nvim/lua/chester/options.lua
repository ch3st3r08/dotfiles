local set=vim.opt

vim.cmd([[syntax enable]]) --Enables syntax highlighting
vim.cmd([[filetype plugin indent on]])
--⋅
set.encoding="utf-8"      --The encoding displayed
set.fileencoding="utf-8"     --"The encoding written to file
set.hidden=true          --"Required to keep multiple buffers open
set.wrap=true          --"Display long lines as just one line
set.pumheight=10        --"Makes opoup menu smaller
set.list=true        --"Shows non-printable charaacters
set.listchars = {tab = "| ", trail = "⋅", nbsp = "⎵"} -- tab char must have 2 chars
set.ruler=true          --"Show the cursor position all the time
set.cmdheight=1        --"More space for displaying messages
set.iskeyword:append('-')        --"Treat dash separated words as a word text object
set.mouse="a"        --"Enable your mouse
set.splitbelow=true         -- "Horizontal splits will automatically be below
set.splitright=true          --"Vertical splits will automatically be to the right
set.conceallevel=0      --"So that I can ´´ in markdown files
set.tabstop=2
set.softtabstop=-1      --"Insert 2 spaces for a tab
set.shiftwidth=0        --"Change the number of space chars inserted for indentation
set.autoindent=true          --"Good auto indent
set.smarttab=true            --"Makes tabbing smarter
set.smartindent=true
set.expandtab=true           --"Converts tabs to spaces
set.laststatus=0        --"Always display the status line
set.relativenumber=true        --  "Line numbers
set.number=true
set.hlsearch=false
set.cursorline=true         -- "Enable hightlightning of the cursor line
set.showtabline=2     --  "Always show tabs
set.showmode=false         -- "We don't need to see thigns like --INSERT --anymore
set.backup=false            --"Recommended by CoC
set.swapfile=false
set.incsearch=true
set.scrolloff=2
set.writebackup=false     -- "Recommended by CoC
set.updatetime=300     -- "Faster completion
set.timeoutlen=500     -- "By default timeoutlen is 1000ms
set.formatoptions:remove("cro")     -- "Stop newline continution comments
set.clipboard="unnamedplus"  --"Copy paste between vim and everything else
set.completeopt={"menu","menuone","noinsert","noselect"}
set.signcolumn="yes"
set.termguicolors=true

vim.g.mapleader = " "

-- 'default', 'atlantis', 'andromeda', 'shusia', 'maia', 'espresso'
vim.g.sonokai_style = "default"

-- 'darker', 'lighter', 'oceanic', 'palenight', 'deep ocean'
vim.g.material_style = "deep ocean"

-- 'default', 'aura', 'neon'
vim.g.edge_style = 'aura'

-- 'storm', 'night', 'day'
vim.g.tokyonight_style = "storm"

-- 'default', 'doom', 'dark', 'light'
vim.g.neon_style = "default"

vim.cmd([[colorscheme sonokai]])

vim.cmd([[
  autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
]])

-- Will later use it on a autogruop
vim.cmd[[
  function MakeTransparentBackground()
      hi Normal guibg=NONE ctermbg=NONE
      hi LineNr guibg=NONE ctermbg=NONE
      hi SignColumn guibg=NONE ctermbg=NONE
      hi EndOfBuffer guibg=NONE ctermbg=NONE
  endfunction
  call MakeTransparentBackground()
]]

-- Startify Configuration Options
vim.g.startify_lists = {
  {header={'  Bookmarks'}, type='bookmarks'},
  {header={'  Files'}, type='files'},
  {header={'  Current Directory ' .. vim.fn.getcwd()}, type='dir'},
}

vim.g.startify_bookmarks = {
  {b='~/.bashrc'},
  {v='~/.config/nvim/init.lua'}
}

vim.g.startify_fortune_use_unicode=1


--Vim-closetag options
vim.g.closetag_filenames = '*.vue,*.html,*.xhtml,*.phtml'
vim.g.closetag_filetypes = 'vue,html,xhtml,phtml'
