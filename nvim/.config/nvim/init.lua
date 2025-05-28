---------- [  EDITOR  ] ----------

-- line numbers
vim.opt.nu = true
vim.opt.rnu = true

-- indentation
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.sw = 4
vim.opt.ts = 4

-- disable search highlighting
vim.opt.hls = false

---------- [ TERMINAL ] ----------

-- set terminal behavior to be somewhat sane
-- (auto-enter insert mode, disable line numbering)
vim.cmd([[
    augroup no_nu_term
        autocmd!
        autocmd TermOpen * set nonu nornu
        autocmd TermOpen * startinsert
    augroup END
]])

---------- [ STYLING  ] ----------

-- enable 24-bit terminal color support
vim.opt.termguicolors = true

vim.api.nvim_set_hl(0, "Function", { fg = "#dcdcaa" })
vim.api.nvim_set_hl(0, "Comment", { fg = "#6a9955" })
vim.api.nvim_set_hl(0, "Constant", { fg = "#569cd6" })
vim.api.nvim_set_hl(0, "Number", { fg = "#b5cea8" })
-- regexp: #646695
-- invalid: #f44747
vim.api.nvim_set_hl(0, "Added", { fg = "#b5cea8" })
vim.api.nvim_set_hl(0, "Removed", { fg = "#ce9178" })
-- changed: #569cd6
vim.api.nvim_set_hl(0, "@lsp.type.macro", { fg = "#569cd6" })
vim.api.nvim_set_hl(0, "String", { fg = "#ce9178" })
vim.api.nvim_set_hl(0, "Keyword", { fg = "#569cd6" })
vim.api.nvim_set_hl(0, "Operator", { fg = "#d4d4d4" })
vim.api.nvim_set_hl(0, "Type", { fg = "#4ec9b0" })
vim.api.nvim_set_hl(0, "cType", { fg = "#569cd6" })
vim.api.nvim_set_hl(0, "@lsp.type.parameter", { fg = "#9cdcfe" })
vim.api.nvim_set_hl(0, "@function.method", { fg = "#dcdcaa" })
vim.api.nvim_set_hl(0, "@variable", { fg = "#9cdcfe" })
vim.api.nvim_set_hl(0, "Statement", { fg = "#c586c0" })
vim.api.nvim_set_hl(0, "PreProc", { fg = "#c586c0" })


--vim.api.nvim_set_hl(0, "@lsp.type.enum", { fg = "#ffd3e8" })
--vim.api.nvim_set_hl(0, "Statement", { fg = "#5995ed" })
--vim.api.nvim_set_hl(0, "Include", { fg = "#5bc0eb" })
--vim.api.nvim_set_hl(0, "@function.method", { fg = "#b79ced" })
--vim.api.nvim_set_hl(0, "Identifier", { fg = "#ddbdd5" })
--vim.api.nvim_set_hl(0, "Special", { fg = "#a0c1d1" })
--vim.api.nvim_set_hl(0, "@lsp.type.typeParameter", { fg = "#eee5bf" })

---------- [ PLUGINS  ] ----------

-- set leader keybinds (required before Lazy is loaded)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- plugin loader
require("config.lazy")

-- telescope: fuzzy finding
local telescope = require('telescope.builtin')

-- nvim-tree: file browser/sidebar
local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")
    
    local function opts(desc)
        return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
        }
    end

    api.config.mappings.default_on_attach(bufnr)

    -- custom nvim-tree keybinds
    -- ...
end
require("nvim-tree").setup({
    disable_netrw = false,
    hijack_netrw = true,
})

-- tabby
local tabby = require("tabby")
tabby.setup()

-- nvim-possession
vim.cmd('set ssop+=curdir')
local poss = require("nvim-possession")
poss.setup({
    autoload = true,
    autoprompt = true,
})

local lualine = require('lualine')
lualine.setup({
    options = {
        theme = 'ayu_dark',
    },
    sections = {
        lualine_c = {
            { "filename", path = 1 },
            {
                poss.status,
                cond = function()
                    return poss.status() ~= nil
                end
            },
        },
    },
})

---------- [   LSP    ] ----------

vim.lsp.enable('clangd')
vim.lsp.config('clangd', {
    cmd = {
        'clangd',
        '--header-insertion=never',
        '--background-index',
    },
})

-- enable error diagnostics inline
vim.diagnostic.config({
    virtual_text = true,
})

---------- [ KEYBINDS ] ----------


-- tabs
vim.keymap.set('n', '<Leader>tn', '<cmd>:tabnew<cr>')
vim.keymap.set('n', '<Leader>tw', '<cmd>:tabclose<cr>')

vim.keymap.set('n', '<Leader>t1', '1gt')
vim.keymap.set('n', '<Leader>t2', '2gt')
vim.keymap.set('n', '<Leader>t3', '3gt')
vim.keymap.set('n', '<Leader>t4', '4gt')
vim.keymap.set('n', '<Leader>t5', '5gt')
vim.keymap.set('n', '<Leader>t6', '6gt')
vim.keymap.set('n', '<Leader>t7', '7gt')
vim.keymap.set('n', '<Leader>t8', '8gt')
vim.keymap.set('n', '<Leader>t9', '9gt')
vim.keymap.set('n', '<Leader>t0', '10gt')

-- windows
vim.keymap.set('n', '<Leader>ww', '<C-w><C-w>')

-- lsp keybinds
vim.keymap.set('n', '<Leader> ',  vim.lsp.buf.completion)
vim.keymap.set('n', '<Leader>g.', vim.lsp.buf.code_action)
vim.keymap.set('n', '<Leader>gr', vim.lsp.buf.rename)
vim.keymap.set('n', '<Leader>gA', vim.lsp.buf.references)
vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition)

-- telescope
vim.keymap.set('n', '<Leader>ff', telescope.find_files)

-- nvim-tree (editor)
-- note: nvim-tree mode keybinds appear above!
vim.keymap.set('n', '<Leader>b', '<cmd>:NvimTreeToggle<cr>')

-- nvim-possession
vim.keymap.set('n', '<Leader>sl', poss.list)
vim.keymap.set('n', '<Leader>sn', poss.new)
vim.keymap.set('n', '<Leader>su', poss.update)
vim.keymap.set('n', '<Leader>sd', poss.delete)

