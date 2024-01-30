return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "plenary",
--        "metals",
    },
    tag = "0.1.5",
    config = function()
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope git files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end, { desc = 'Telescope grep string' })

        local telescope = require("telescope")
        --vim.keymap.set('n', '<leader>mc', telescope.extensions.metals.commands, { desc = 'Telescope Metals Menu' })
    end

}
