local lsp_zero = require('lsp-zero')

local telescope = require('telescope.builtin')

lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    
    --vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    --vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    --vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
    --vim.keymap.set('n', '<Space>rn', vim.lsp.buf.rename, opts)
    lsp_zero.default_keymaps({buffer= bufnr})
    -- use telescope's references
    vim.keymap.set('n', 'gr', telescope.lsp_references, opts)
end)

require("mason").setup {}
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyright", "gopls"},
    handlers = {
        lsp_zero.default_setup,
    },
})


require('lspconfig').lua_ls.setup({})
require('lspconfig').gopls.setup({})
require('lspconfig').pyright.setup({})
require('lspconfig').metals.setup({})


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

