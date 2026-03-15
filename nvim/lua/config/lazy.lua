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
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup({
        --
      })

      vim.cmd('colorscheme github_dark_dimmed')
    end,
  },
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
    -- This seems like a good config: https://github.com/mrusme/dotfiles/blob/e956d3a663843ec36251847a53006dddb9dcdcab/.config/nvim/init.lua
    "neovim/nvim-lspconfig",
    config = function()
      -- In the future, let's do something like this instead:
      -- https://github.com/softwareQinc/nvim-sq/blob/a773f60b0ae41134022a5a1f3711ced2fecbfc9e/lua/plugins/lsp.lua#L81
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("zls", {
        cmd = { vim.fn.expand("~/.zls/bin/zls") },
        filetypes = { "zig" },
        root_markers = { "build.zig", ".git" },
        capabilities = lsp_capabilities,
      })
      vim.lsp.enable("zls")

      vim.lsp.config("gopls", {
        cmd = { "gopls" },
        filetypes = { "go" },
        root_makers = { "go.mod", "go.sum", ".git" },
        capabilities = lsp_capabilities,
        settings = {
          gopls = {
            gofumpt = true,
          }
        }
      })
      vim.lsp.enable("gopls")
    end
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
