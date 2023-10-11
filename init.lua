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

require('config')

vim.cmd([[
if exists("g:neovide")
	set guifont=FiraCode\ Nerd\ Font:h11
	"let g:neovide_scroll_animation_length = 2.0
endif
]])

require("lazy").setup("plugins")
