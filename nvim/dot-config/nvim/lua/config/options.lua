-- Dealing with nested instances
vim.env.NVIM_LISTEN_ADDRESS = vim.v.servername
-- Options
local opt = vim.opt
opt.termguicolors = true
opt.confirm = true
opt.number = true
opt.relativenumber = true
opt.laststatus = 3
opt.signcolumn = "yes"
opt.list = true
opt.expandtab = true
opt.shiftwidth = 2
opt.smartcase = true
opt.smartindent = true
opt.timeoutlen = 500
opt.mouse = "a"
opt.scrolloff = 2
opt.showmode = false
opt.splitbelow = true
opt.splitright = true
opt.completeopt = { "fuzzy", "menuone", "popup", "noselect", "noinsert" }
vim.o.winborder = 'rounded'
vim.diagnostic.config({ virtual_text = { current_line = true } })
--Explorer
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 0
vim.g.netrw_browse_split = 4
vim.cmd.colorscheme('rose-pine')
vim.filetype.add({
  extension = {
    yml = 'yaml.ansible'
  }
})
