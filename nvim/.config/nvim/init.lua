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

-- adjust search settings
--vim.opt.hls = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- highlight trailing whitespace
vim.cmd('hi EoLSpace ctermbg=238 guibg=#333333')
vim.api.nvim_create_autocmd({'BufWinEnter', 'WinEnter'}, {
    pattern = '*',
    callback = function()
        vim.cmd('match EoLSpace /\\s\\+$/')
    end
})

-- always show tab bar
vim.o.showtabline = 2

-- set scrolloff (lines of padding at top and bottom)
vim.opt.scrolloff = 2

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
require("nvim-tree").setup({
    disable_netrw = false,
    hijack_netrw = true,
})

-- tabby
local tabby = require("tabby")
tabby.setup({
    preset = 'active_wins_at_tail',
    option = {
        lualine_theme = 'powerline_dark',
    },
})

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
        theme = 'powerline_dark',
    },
    sections = {
        lualine_c = {
            {
                poss.status,
                cond = function()
                    return poss.status() ~= nil
                end
            },
            { "filename", path = 4 },
        },
    },
})

-- toggleterm
local toggleterm = require('toggleterm')
toggleterm.setup({
    open_mapping = [[<c-`>]],
    hide_numbers = true,
    multiwindow = true,
    size = 25,
    close_on_exit = true,
})

-- ts-context
-- local tscontext = require('treesitter-context')
-- tscontext.setup({
--     enable = true,
--     multiwindow = true,
--     mode = 'topline',
-- })


---------- [   LSP    ] ----------

local coq = require('coq')

-- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
vim.lsp.config('lua_ls', {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath('config')
                and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                version = 'LuaJIT',
                path = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                }
            }
        })
    end,
    settings = {
        Lua = {}
    }
})
vim.lsp.enable('lua_ls')

vim.lsp.config('clangd', coq.lsp_ensure_capabilities({
    cmd = {
        'clangd',
        '--header-insertion=never',
        '--background-index',
    },
}))
vim.lsp.enable('clangd')

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
vim.keymap.set('n', 'g.', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gr', vim.lsp.buf.rename)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gh', vim.lsp.buf.hover)

-- telescope
vim.keymap.set('n', '<Leader>ff', telescope.find_files)
vim.keymap.set('n', '<Leader>fr', telescope.lsp_references)
vim.keymap.set('n', '<Leader>fs', telescope.lsp_workspace_symbols)
vim.keymap.set('n', '<Leader>fg', telescope.live_grep)

-- nvim-tree (editor)
-- note: nvim-tree mode keybinds appear above!
vim.keymap.set('n', '<Leader>b', '<cmd>:NvimTreeToggle<cr>')

-- nvim-possession
vim.keymap.set('n', '<Leader>sl', poss.list)
vim.keymap.set('n', '<Leader>sn', poss.new)
vim.keymap.set('n', '<Leader>su', poss.update)
vim.keymap.set('n', '<Leader>sd', poss.delete)

