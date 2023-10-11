return {
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function ()
	-- 		vim.cmd([[colorscheme tokyonight]])
	-- 	end,
	-- },
	{ "catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function ()
			vim.cmd([[colorscheme catppuccin-frappe]])
		end,
	},
	{
		"folke/which-key.nvim",
		opts = {
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+git" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
				["<leader>c"] = { name = "+comments" },
				["<leader>l"] = { name = "+lsp" },
				["<leader>d"] = { name = "+debug" },
				["<leader>s"] = { name = "+find and replace" },
				["<leader>b"] = { name = "+buffer" },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},
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
