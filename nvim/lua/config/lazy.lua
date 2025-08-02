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
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
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
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<space>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<space>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<space>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<space>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end
  }
})
