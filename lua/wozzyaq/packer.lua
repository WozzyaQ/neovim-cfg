vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    --use { 'rose-pine/neovim', as = 'rose-pine', config = function() vim.cmd("colorscheme rose-pine") end }
    use { 'Mofiqul/vscode.nvim' }
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    use('nvim-lualine/lualine.nvim')
    use {

        'VonHeikemen/lsp-zero.nvim',
        bracnh = 'v3.x',

        requires = {
            -- lsp support
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "neovim/nvim-lspconfig" },

            -- autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            { "saadparwaiz1/cmp_luasnip" },

            -- snippets
            { "rafamadriz/friendly-snippets" },
            { "L3MON4D3/LuaSnip" },
        }
    }
    use {
        "folke/todo-comments.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" }
        }
    }
    use {
        "scalameta/nvim-metals",
        requires = {
            { "nvim-lua/plenary.nvim" }
        }
    }
end)
