return {
    "VonHeikemen/lsp-zero.nvim",
    tag = "v3.x",
    dependencies = {
        -- lsp support
        {
            "williamboman/mason.nvim"
        },
        { "williamboman/mason-lspconfig.nvim" },
        { "neovim/nvim-lspconfig" },
        -- metals support
        { "scalameta/nvim-metals" },
        "plenary",
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

        -- null ls
        { "jose-elias-alvarez/null-ls.nvim" },
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
            ensure_installed = { "lua_ls", "pyright", "gopls", "tsserver"},
            handlers = {
                lsp_zero.default_setup,
            },
        })

        require('lspconfig').lua_ls.setup({})
        require('lspconfig').gopls.setup({})
        require('lspconfig').pyright.setup({
            capabilities = lsp_zero.get_capabilities(),
        })
        require('lspconfig').tsserver.setup({
            capabilities = lsp_zero.get_capabilities(),
        })

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

        -- Metals configuration
        local metals_config = require("metals").bare_config()
        -- Example of settings
        metals_config.settings = {
            showImplicitArguments = true,
            excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
        }

        -- Based on https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/quick-recipes.md#setup-with-nvim-metals
        -- seemingly, we need to share lsp_zero capabilities to metals config
        metals_config.capabilities = lsp_zero.get_capabilities()
        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "scala", "sbt", "java" },
            callback = function()
                require("metals").initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
        })

        -- null ls
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.black
            }
        })
    end
}
