local map = function(mode, lhs, rhs)
    local opts = {noremap=true, silent=true}
    return vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

--"Telescope options
map('n','<leader>ff',"<cmd>lua require('telescope.builtin').find_files()<CR>")
map('n','<leader>fg',"<cmd>lua require('telescope.builtin').live_grep()<CR>")
map('n','<leader>fb',"<cmd>lua require('telescope.builtin').buffers()<CR>")
map('n','<leader>fh',"<cmd>lua require('telescope.builtin').help_tags()<CR>")

--"nvim-tree options
map('n', '<C-n>', ':NvimTreeToggle<CR>')
map('n', '<leader>r', ':NvimTreeRefresh<CR>')
map('n', '<leader>n ', ':NvimTreeFindFile<CR>')

--"Trouble
map("n", "<leader>xx", "<cmd>Trouble<cr>")
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>")
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>")
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>")
map("n", "gR", "<cmd>Trouble lsp_references<cr>")

--"Mis remapeos
--"Guardar archivo
map('n','<leader>w', ':w<CR>')
map('i','<leader>w', '<ESC>:w<CR>')

--"Salir del modo terminal de neoVim
map('t','<leader><Esc>','<C-\\><C-n>')

--"Abrir mi configuracion de NEOVIM
map('n','<leader>ee',':e $MYVIMRC<CR>')

--"Deshabilitar flechas de direccion
map('n','<up>','')
map('n','<down>','')
map('n','<left>','')
map('n','<right>','')

--"Redimencionar splits
map('n','<right>',':vertical resize +5<CR>')
map('n','<left>',':vertical resize -5<CR>')
map('n','<up>',':resize +5<CR>')
map('n','<down>',':resize -5<CR>')

--"Moverse entre buffers
map('n','<Tab>',':bn<CR>')
map('n','<S-Tab>',':bp<CR>')

--"Abrir terminal"

--"Abrir terminal Neoterm
map('n','<c-t>',':8split<CR>:Topen<CR>:setl nobuflisted<CR>:redrawt<CR>')
map('v','<c-t>',':8split<CR>:Topen<CR>:setl nobuflisted<CR>:redrawt<CR>')

map('t','<leader>x','<C-\\><C-n>:Tclose!<CR>')
map('t','<leader>q','<C-\\><C-n>:Tclose<CR>')

--"Cerrar buffers
map('n','<leader>x',':Bwipeout<CR>')
map('v','<leader>x',':Bwipeout<CR>')

--"Vim vim-which-key maps
map('n','<leader>',":<c-u>WhichKey '<Space>'<CR>")


