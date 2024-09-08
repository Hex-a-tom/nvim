return {
	{
		"catppuccin/nvim",
		enabled = false,
		name = "catppuccin",
		priority = 1000,
		-- config = function ()
		-- 	vim.cmd([[colorscheme catppuccin-mocha]])
		-- end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		enabled = false,
		priority = 1000,
		config = function ()
			vim.cmd([[colorscheme gruvbox]])
		end,
	},
	{
		"sainnhe/everforest",
		priority = 1000,
		config = function ()
			vim.g.everforest_enable_italic = true
			vim.g.everforest_background = 'hard'
			vim.cmd([[colorscheme everforest]])
		end,
	},
	{
		"folke/which-key.nvim",
		opts = {
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
				[ "<leader>b"] = { group = "buffer" },
				[ "<leader>c"] = { group = "comments" },
				[ "<leader>d"] = { group = "debug" },
				[ "<leader>f"] = { group = "file/find" },
				[ "<leader>g"] = { group = "git" },
				[ "<leader>l"] = { group = "lsp" },
				[ "<leader>o"] = { group = "open" },
				[ "<leader>s"] = { group = "find and replace" },
				[ "<leader>x"] = { group = "diagnostics/quickfix" },
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
