vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.mouse='a'
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.relativenumber = true
vim.opt.number=true
vim.opt.cc = '80'
vim.opt.wildmode = {'longest', 'list'}
vim.opt.cursorline = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.ttyfast = true
vim.opt.updatetime = 300
vim.g.mapleader = ','

vim.opt.signcolumn= 'yes'

vim.opt.backup = false
vim.opt.writebackup = false

vim.cmd [[
  syntax enable
  colorscheme dracula
]]

return true
