require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "gopls", "lua_ls", "pyright", "ts_ls", "rust_analyzer" },
})

-- Native LSP setup
vim.lsp.config("gopls", {})
vim.lsp.config("pyright", {})
vim.lsp.config("tsserver", {}) -- or ts_ls if you want the newer one
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } }
    }
  }
})
vim.lsp.config("rust_analyzer", {})

vim.lsp.enable("gopls")
vim.lsp.enable("pyright")
vim.lsp.enable("tsserver") -- or ts_ls
vim.lsp.enable("lua_ls")
vim.lsp.enable("rust_analyzer")
