require("config.lazy")
require("config.options")
require("config.plugins")
require("config.treesitter")
require("config.completion")

vim.g.python3_host_prog = os.getenv("HOME") .. "/.venvs/nvim/bin/python"
vim.o.signcolumn = "yes"
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
vim.opt.clipboard = "unnamedplus"

vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format()
end, { desc = "LSP Format" })

-- Move selected lines down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")

-- Move selected lines up
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Move selected lines right (indent)
vim.keymap.set("v", "<A-l>", ">gv")

-- Move selected lines left (dedent)
vim.keymap.set("v", "<A-h>", "<gv")
