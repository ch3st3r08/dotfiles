-- Keymaps
local map = vim.keymap.set
map({'n', 'v'},'<leader>y', '"+y', { desc = "Copy to Clipboard"})
map({'n', 'v'},'<leader>p', '"+p', { desc = "Paste from Clipboard"})
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
--map('n', '<leader>e', '<cmd>20Lex<CR>')
map({'n'}, '<ESC>', '<cmd>nohlsearch<CR>', {desc = "Clear Search"})
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map({ "n" }, "<C-s>", "<cmd>w<cr>", { desc = "Save File" })
map("n", "x", '"_x', {desc="Delete one char"})

--MiniBufremove
map("n", "<localleader>d", '<cmd>lua MiniBufremove.wipeout()<cr>')

--Telescope
map({ "n" }, "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Search Files" })
map({ "n" }, "<leader>fF", "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>", { desc = "Search ALL Files" })
map({ "n" }, "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Search Buffers" })
map({ "n" }, "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Search Words" })
map({ "n" }, "<leader>fG", "<cmd>lua require('telescope.builtin').live_grep({additional_args={'--follow','--hidden'}})<cr>", { desc = "Search ALL Words" })

-- Lsp 
map({"n"},  "<localleader>f", "<cmd>lua vim.lsp.buf.format()<cr>", { desc = "Format File"})

-- Terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Escape from terminal" })
map("n", "<leader>tt", "<cmd>ToggleTerm<CR>", {desc="Open Terminal", noremap = true, silent = true})
map("n", "<leader>tg", "<cmd>lua require('toggleterm.terminal').Terminal:new({cmd='lazygit', direction='float', hidden=true}):toggle()<CR>", {desc="Open Lazygit", noremap = true, silent = true})
