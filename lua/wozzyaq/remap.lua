vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set('', '<leader>y', '"+y', { desc = 'Yank to clipboard' })
vim.keymap.set('', '<leader>Y', '"+y$', { desc = 'Yank until EOL to clipboard' })
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste after cursor from clipboard' })
vim.keymap.set('n', '<leader>P', '"+P', { desc = 'Paste before cursor from clipboard' })


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line up" })

