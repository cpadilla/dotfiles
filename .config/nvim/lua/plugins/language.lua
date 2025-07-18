return {
    {
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig.nvim'
        }
    },
    { 'neovim/nvim-lspconfig' },
    { 'simrat39/rust-tools.nvim' },

    -- Modern TypeScript LSP
    {
        'pmizio/typescript-tools.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'neovim/nvim-lspconfig',
        }
    },

    -- Completion framework:
    { 'hrsh7th/nvim-cmp' },

    -- LSP completion source:
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-vsnip' },
    { 'hrsh7th/cmp-vsnip' },
    { 'hrsh7th/vim-vsnip' },

    -- Optional signature hint UI
    { 'ray-x/lsp_signature.nvim' },
}
