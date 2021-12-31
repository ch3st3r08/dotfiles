local actions = require("telescope.actions")
local trouble_status_ok, trouble = pcall(require, "trouble.providers.telescope")
if not trouble_status_ok then
  return
end

local telescope = require("telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
}
