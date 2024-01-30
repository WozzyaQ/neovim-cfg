return {
    "VonHeikemen/lsp-zero.nvim",
    tag = "v3.x",
    dependencies = {
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
    },
    config = function()
        local lsp_zero = require('lsp-zero')

        local telescope = require('telescope.builtin')

        lsp_zero.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }
            lsp_zero.default_keymaps({ buffer = bufnr })
            -- use telescope's references
            vim.keymap.set('n', 'gr', telescope.lsp_references, opts)
        end)

        require("mason").setup {}
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "pyright", "gopls" },
            handlers = {
                lsp_zero.default_setup,
            },
        })

        require('lspconfig').lua_ls.setup({})
        require('lspconfig').gopls.setup({})
        require('lspconfig').pyright.setup({})
        --require('lspconfig').metals.setup({})


        local cmp = require('cmp')


        cmp.setup({
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
            })
        })
    end
}
