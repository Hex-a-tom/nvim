return {
	{
		"airblade/vim-gitgutter",
		event = "VeryLazy",
		config = function ()
			vim.o.updatetime = 300
			-- vim.o.incsearch = false
			vim.wo.signcolumn = 'yes'
		end
	},
	{
		-- TODO: Fix confirmation dialog
		"TimUntersberger/neogit",
		opts = {
			disable_commit_confirmation = true,
			integrations = {
				-- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
				-- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
				--
				-- Requires you to have `sindrets/diffview.nvim` installed.
				-- use { 
				--   'TimUntersberger/neogit', 
				--   requires = { 
				--     'nvim-lua/plenary.nvim',
				--     'sindrets/diffview.nvim' 
				--   }
				-- }
				diffview = true
			},
		},
		dependencies = {
			"sindrets/diffview.nvim",
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gg", "<Cmd>Neogit<CR>", desc = "Start Neogit"},
		}
	}
}
