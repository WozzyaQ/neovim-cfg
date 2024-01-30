
-- make tab behave as 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- enable relative numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- disable vim info
vim.opt.showmode = false

-- disable line wraps
vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

-- sticky scroll
vim.opt.scrolloff = 8

vim.opt.colorcolumn = "120"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
