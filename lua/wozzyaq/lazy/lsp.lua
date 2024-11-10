return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            -- lsp support
            {
                "williamboman/mason.nvim"
            },
            { "williamboman/mason-lspconfig.nvim" },
            { "neovim/nvim-lspconfig" },
            -- metals support
            { "scalameta/nvim-metals" },
            {"nvim-lua/plenary.nvim"},
            -- autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- snippets
            { "rafamadriz/friendly-snippets" },
            { "L3MON4D3/LuaSnip" },

            -- null ls
            { "jose-elias-alvarez/null-ls.nvim" },
        },
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.on_attach(function(client, bufnr)
                if client.name == 'ruff_lsp' then
                    client.server_capabilities.hoverProvider = false
                end
                local opts = { buffer = bufnr, remap = false }
                lsp_zero.default_keymaps({ buffer = bufnr })

                -- use telescope's go-to references
                local telescope = require('telescope.builtin')
                vim.keymap.set('n', 'gr', telescope.lsp_references, opts)
            end)


            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = { 
                    "lua_ls",
                    "pyright",
                    "gopls"
                },
                handlers = {
                    lsp_zero.default_setup,
                },
            })


            require('lspconfig').lua_ls.setup({})
            require('lspconfig').gopls.setup({
                capabilities = lsp_zero.get_capabilities(),
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                    },
                },
            })
            require('lspconfig').pyright.setup({
                capabilities = lsp_zero.get_capabilities(),
                settings = {
                    pyright = {
                        -- use Ruff's organizer
                        disableOrganizeImports = true
                    },
                    python = {
                        --analysis = {
                        --    ignore = { '*' },
                        --},
                    },
                },
            })
           require('lspconfig').lsp_ruff.setup({
               init_options = {
                    settings = {
                        args = {}
                    }
                }
            })

            local cmp = require('cmp')
            cmp.setup({
                window = {
                    -- bordered seemingly work well with copilot when tabbing options
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                })

            })

            -- Metals configuration
            local metals_config = require("metals").bare_config()
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
        end
    },
}
