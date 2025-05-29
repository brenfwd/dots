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
        'ms-jpq/coq_nvim',
        branch = 'coq',
        init = function()
            vim.g.coq_settings = {
                auto_start = 'shut-up',
            }
        end
    },
    {
        'ms-jpq/coq.artifacts',
        branch = 'artifacts',
    },
    -- {
    --     'nvim-treesitter/nvim-treesitter-context',
    --     dependencies = {
    --         {
    --             'nvim-treesitter/nvim-treesitter',
    --             branch = 'main',
    --             build = ':TSUpdate',
    --             lazy = false,
    --         },
    --     },
    -- },
}
