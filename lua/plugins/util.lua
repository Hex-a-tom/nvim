return {
	"RRethy/vim-illuminate",
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
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			buftype_exclude = {
				"nofile",
				"terminal",
			},
			filetype_exclude = {
				"help",
				"startify",
				"aerial",
				"alpha",
				"dashboard",
				"lazy",
				"neogitstatus",
				"NvimTree",
				"neo-tree",
				"Trouble",
			},
			context_patterns = {
				"class",
				"return",
				"function",
				"method",
				"^if",
				"^while",
				"jsx_element",
				"^for",
				"^object",
				"^table",
				"block",
				"arguments",
				"if_statement",
				"else_clause",
				"jsx_element",
				"jsx_self_closing_element",
				"try_statement",
				"catch_clause",
				"import_statement",
				"operation_type",
			},
			show_trailing_blankline_indent = false,
			use_treesitter = true,
			char = "▏",
			context_char = "▏",
			show_current_context = true,
		},
		event = "VeryLazy",
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			ignore = '^$',
			toggler = {
				line = '<leader>cc',
				block = '<leader>cb',
			},
			opleader = {
				line = 'cc',
				block = 'cb',
			},
			mappings = {
				basic = true,
				extra = false,
			},
		},
		keys = {
			{"<leader>cc", desc = "Toggle Line Comment"},
			{"<leader>cb", desc = "Toggle Block Comment"},
			{"<leader>c", desc = "Comment"},
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
}
