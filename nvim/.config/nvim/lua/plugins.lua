return {
    {
        -- Telescope.nvim: fuzzy finding for everything
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && cmake --build build --config Release',
            },
        }
    },
    {
        'nvim-tree/nvim-tree.lua', tag = 'v1.12',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
        'neovim/nvim-lspconfig', tag = 'v2.2.0',
    },
    {
        'nanozuki/tabby.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
        "gennaro-tedesco/nvim-possession",
        dependencies = {
            "ibhagwan/fzf-lua",
        },
        config = true,
    },
    {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        'f-person/git-blame.nvim',
        event = 'VeryLazy',
    },
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        config = true,
    },
    {
        'hrsh7th/nvim-cmp',
        tag = 'v0.0.2',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
        },
        init = function()
            local has_words_before = function()
                unpack = unpack or table.unpack
                local cur = vim.api.nvim_win_get_cursor(0)
                local line, col = unpack(cur)
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
            end -- has_words_before

            local cmp = require('cmp')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end, -- expand
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space'] = cmp.mapping.complete(),

                    ['<C-e>'] = cmp.mapping.abort(),

                    ['<CR>'] = cmp.mapping.confirm({ select = true }),

                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                            -- cmp.confirm({ select = true })
                        elseif vim.snippet.active({ direction = 1 }) then
                            vim.schedule(function()
                                vim.snippet.jump(1)
                            end)
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }), -- <Tab>

                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif vim.snippet.active({ direction = -1 }) then
                            vim.schedule(function()
                                vim.snippet.jump(-1)
                            end)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }), -- <S-Tab>
                }),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                },
            })
        end, -- init
    },
    {
      "Isrothy/neominimap.nvim",
      version = "v3.x.x",
      lazy = false,
      init = function()
        -- The following options are recommended when layout == "float"
        vim.opt.wrap = false
        vim.opt.sidescrolloff = 36 -- Set a large value

        --- Put your configuration here
        ---@type Neominimap.UserConfig
        vim.g.neominimap = {
          auto_enable = true,
        }
      end,
    },
    -- {
    --     'ms-jpq/coq_nvim',
    --     branch = 'coq',
    --     init = function()
    --         vim.g.coq_settings = {
    --             auto_start = 'shut-up',
    --         }
    --     end
    -- },
    -- {
    --     'ms-jpq/coq.artifacts',
    --     branch = 'artifacts',
    -- },
    {
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter',
                branch = 'main',
                build = ':TSUpdate',
                lazy = false,
            },
        },
    },
}
