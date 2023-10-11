return {
	"RRethy/vim-illuminate",
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	{
		"ggandor/leap.nvim",
		config = function ()
			require('leap').add_default_mappings()
		end
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},
	{
		"tpope/vim-repeat",
	},
	{
		"ahmedkhalf/project.nvim",
		main = "project_nvim",
		opts = {
			silent_chdir = false,
		},
		event = "VeryLazy",
	},
	{
		"AckslD/nvim-neoclip.lua",
		config = true,
		event = "InsertEnter",
	},
	{
		"tmsvg/pear-tree",
		config = function ()
			vim.g.pear_tree_smart_openers = 1
			vim.g.pear_tree_smart_closers = 1
			vim.g.pear_tree_smart_backspace = 1

			vim.g.pear_tree_ft_disabled = {"TelescopePrompt"}
		end,
		event = "InsertEnter",
		enabled = false,
	},
	{
		"jiangmiao/auto-pairs",
		event = "InsertEnter",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "▎", tab_char = "▎" },
			scope = { enabled = false }
		},
		event = "VeryLazy",
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			ignore = '^$',
			toggler = {
				line = '<leader>cc',
				block = '<leader>cb',
			},
			mappings = {
				basic = true,
				extra = false,
			},
		},
		keys = {
			{"<leader>cc", desc = "Toggle Line Comment"},
			{"<leader>cb", desc = "Toggle Block Comment"},
		},
		event = "VeryLazy"
	},
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		init = function ()
			vim.keymap.set('n', '<F3>', '<cmd>UndotreeToggle<CR>', {silent = true, noremap = true})
		end
	},
	{
		"nvim-pack/nvim-spectre",
		-- stylua: ignore
		keys = {
			{ "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
		},
	},
}
