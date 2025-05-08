-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


vim.opt.nu = true
vim.opt.rnu = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.sw = 4
vim.opt.ts = 4
vim.opt.hls = false

require("config.lazy")

local telescope = require('telescope.builtin')
vim.keymap.set('n', '<Leader>ff', telescope.find_files)

