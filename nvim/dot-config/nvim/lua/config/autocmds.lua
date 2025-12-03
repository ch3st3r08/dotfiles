-- Auto Commands
local chester_group = vim.api.nvim_create_augroup("chester",{ clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  group = chester_group,
---@diagnostic disable-next-line: unused-local
  callback = function(ev)
    vim.opt.number = false
    vim.opt_local.buflisted = false
  end
})

vim.api.nvim_create_autocmd("FileType", {
    group = chester_group,
    pattern = "netrw",
    callback = function(ev)
        vim.opt_local.bufhidden="wipe"
    end,
})

-- Functions
function _G.create_named_terminal(name)
  vim.cmd('botright 5sp term://zsh')
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(buf, name)
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { buffer = buf })
end

vim.keymap.set('n', '<leader>te', function()
  create_named_terminal("term1")
end, { desc="Open terminal"})

-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client:supports_method('textDocument/completion') then
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--   end,
-- })
