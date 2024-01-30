vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- yank to clipboard
vim.keymap.set('', '<leader>y', '"+y')
-- yank until EOL to clipboard
vim.keymap.set('', '<leader>Y', '"+y$')
-- paste after cursor from clipboard
vim.keymap.set('n', '<leader>p', '"+p')
-- paste before cursor from clipboard
vim.keymap.set('n', '<leader>P', '"+P')


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line up" })



