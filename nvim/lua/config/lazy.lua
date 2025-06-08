local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim", lazypath})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "nvim-lua/plenary.nvim" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "lewis6991/gitsigns.nvim" },
  { "folke/trouble.nvim" },
  { "nvim-lualine/lualine.nvim" },
  { "nvim-tree/nvim-tree.lua" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      print("telescope")
    end
  }
})
