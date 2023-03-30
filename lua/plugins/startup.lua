return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function ()
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"folke/which-key.nvim",
		config = true,
	},
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"goolord/alpha-nvim",
		opts = function ()
			local startify = require'alpha.themes.startify'

			startify.section.top_buttons.val = {
				startify.button( "e", "New file" , ":ene <BAR> startinsert <CR>"),
				startify.button( "p", "Load project", ":Telescope projects<CR>")
			}

			startify.mru_opts.autocd = true

			return startify.config
		end,
		dependencies = {"nvim-web-devicons"},
	},
}
