return {
    {
        -- Telescope.nvim: fuzzy finding for everything
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
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
}
