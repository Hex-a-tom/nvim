local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.keymap.set('n', '<Space>', '<NOP>', {silent = true})

vim.api.nvim_set_option('number', true)
vim.api.nvim_set_option('relativenumber', true)
vim.api.nvim_set_option('autoindent', true)
vim.api.nvim_set_option('tabstop', 4)
vim.api.nvim_set_option('shiftwidth', 4)
vim.api.nvim_set_option('smarttab', true)
vim.api.nvim_set_option('softtabstop', 4)
vim.api.nvim_set_option('mouse', 'a')
vim.api.nvim_set_option('background', 'dark')
vim.api.nvim_set_option('cursorline', true)
vim.cmd([[set noshowmode]])
vim.api.nvim_set_option('signcolumn', 'yes')
vim.api.nvim_set_option('laststatus', 3)
vim.api.nvim_set_option('wrap', false)

vim.api.nvim_set_option('termguicolors', true)

vim.cmd([[
if exists("g:neovide")
	set guifont=FiraCode\ Nerd\ Font:h11
	"let g:neovide_scroll_animation_length = 2.0
endif
]])

local opts = { noremap = true, silent = true }

vim.keymap.set('i', '<A-h>', '<cmd>wincmd h<CR>', opts)
vim.keymap.set('i', '<A-j>', '<cmd>wincmd j<CR>', opts)
vim.keymap.set('i', '<A-k>', '<cmd>wincmd k<CR>', opts)
vim.keymap.set('i', '<A-l>', '<cmd>wincmd l<CR>', opts)
vim.keymap.set('t', '<A-h>', '<cmd>wincmd h<CR>', opts)
vim.keymap.set('t', '<A-j>', '<cmd>wincmd j<CR>', opts)
vim.keymap.set('t', '<A-k>', '<cmd>wincmd k<CR>', opts)
vim.keymap.set('t', '<A-l>', '<cmd>wincmd l<CR>', opts)
vim.keymap.set('n', '<A-h>', '<cmd>wincmd h<CR>', opts)
vim.keymap.set('n', '<A-j>', '<cmd>wincmd j<CR>', opts)
vim.keymap.set('n', '<A-k>', '<cmd>wincmd k<CR>', opts)
vim.keymap.set('n', '<A-l>', '<cmd>wincmd l<CR>', opts)

vim.keymap.set('i', '<A-Left>',	'<cmd>wincmd h<CR>', opts)
vim.keymap.set('i', '<A-Down>',	'<cmd>wincmd j<CR>', opts)
vim.keymap.set('i', '<A-Up>',	'<cmd>wincmd k<CR>', opts)
vim.keymap.set('i', '<A-Right>','<cmd>wincmd l<CR>', opts)
vim.keymap.set('t', '<A-Left>',	'<cmd>wincmd h<CR>', opts)
vim.keymap.set('t', '<A-Down>',	'<cmd>wincmd j<CR>', opts)
vim.keymap.set('t', '<A-Up>',	'<cmd>wincmd k<CR>', opts)
vim.keymap.set('t', '<A-Right>','<cmd>wincmd l<CR>', opts)
vim.keymap.set('n', '<A-Left>',	'<cmd>wincmd h<CR>', opts)
vim.keymap.set('n', '<A-Down>',	'<cmd>wincmd j<CR>', opts)
vim.keymap.set('n', '<A-Up>',	'<cmd>wincmd k<CR>', opts)
vim.keymap.set('n', '<A-Right>','<cmd>wincmd l<CR>', opts)

require("lazy").setup("plugins")
