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

if vim.g.neovide then
    vim.o.guifont="GoogleSansCode Nerd Font Propo,Google Sans Code,ZedMono Nerd Font Propo,Iosevka Nerd Font Propo:h11:#h-slight"
end

require("lazy").setup("plugins")
