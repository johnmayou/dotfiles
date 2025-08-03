require("config.lazy")
require("config.options")
require("config.plugins")
require("config.lsp")
require("config.treesitter")
require("config.completion")

vim.g.python3_host_prog = os.getenv("HOME") .. "/.venvs/nvim/bin/python"
vim.o.signcolumn = "yes"
