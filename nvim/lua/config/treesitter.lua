require("nvim-treesitter.configs").setup({
  ensure_installed = { "go", "python", "typescript", "lua", "rust" },
  highlight = { enable = true },
})
