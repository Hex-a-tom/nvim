return {
	"RRethy/vim-illuminate",
	{
		"ggandor/leap.nvim",
		config = function ()
			require('leap').add_default_mappings()
		end
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
		}
	},
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		init = function ()
			vim.keymap.set('n', '<F3>', '<cmd>UndotreeToggle<CR>', {silent = true, noremap = true})
		end
	},
}
