-- Setup tests

-- -- Setup nvim-test
-- local nvim_test = require "nvim-test"
-- nvim_test.setup {
--   run = false,
-- }

-- Setup nvim-treesitter
vim.o.runtimepath = vim.fn.getcwd() .. "/nvim-treesitter," .. vim.o.runtimepath
local nvim_treesitter = require "nvim-treesitter.configs"
nvim_treesitter.setup {
  ensure_installed = {
    "go",
    "javascript",
    "lua",
    "python",
    "rust",
    "typescript",
  },
  sync_install = true,
}

return true
