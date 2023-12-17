return {
	{
		"airblade/vim-gitgutter",
		event = "VeryLazy",
		keys = {
			{ "<leader>gj", "<cmd>GitGutterPrevHunk<cr>", desc = "Next Hunk" },
			{ "<leader>gk", "<cmd>GitGutterNextHunk<cr>", desc = "Prev Hunk" },
		},
		config = function ()
			vim.o.updatetime = 300
			-- vim.o.incsearch = false
			vim.wo.signcolumn = 'yes:1'
		end,
		enabled = false,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				add          = { text = '▎' },
				change       = { text = '▎' },
				delete       = { text = '_' },
				topdelete    = { text = '‾' },
				changedelete = { text = '~' },
				untracked    = { text = '┆' },
			},
		},
	},
	{
		"TimUntersberger/neogit",
		opts = {
			disable_commit_confirmation = true,
			integrations = {
				-- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
				-- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
				--
				-- Requires you to have `sindrets/diffview.nvim` installed.
				diffview = true
			},
		},
		dependencies = {
			"diffview.nvim",
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gg", "<Cmd>Neogit<CR>", desc = "Start Neogit"},
		}
	},
	{
		"sindrets/diffview.nvim",
		keys = {
			{ "<leader>gd", "<Cmd>DiffviewOpen<cr>", desc = "Open diff view" },
			{ "<leader>gh", "<Cmd>DiffviewFileHistory<cr>", desc = "Open project history" },
			{ "<leader>gf", "<Cmd>DiffviewFileHistory %<cr>", desc = "Open file history" },
			{ "<leader>gc", "<Cmd>DiffviewClose<cr>", desc = "Close diff view" },
		},
		cmd = {
			"DiffviewOpen",
			"DiffviewFileHistory",
			"DiffviewToggleFiles",
			"DiffviewClose",
			"DiffviewFocusFiles",
			"DiffviewLog",
			"DiffviewRefresh",
		},
		opts = {
			diff_binaries = false,    -- Show diffs for binaries
			enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
			git_cmd = { "git" },      -- The git executable followed by default args.
			hg_cmd = { "hg" },        -- The hg executable followed by default args.
			use_icons = true,         -- Requires nvim-web-devicons
			show_help_hints = true,   -- Show hints for how to open the help panel
			watch_index = true,       -- Update views and index buffers when the git index changes.
			icons = {                 -- Only applies when use_icons is true.
				folder_closed = "",
				folder_open = "",
			},
			signs = {
				fold_closed = "",
				fold_open = "",
				done = "✓",
			},
			hooks = {
				diff_buf_win_enter = function (bufnr, winid, ctx)
					-- Highlight 'DiffChange' as 'DiffDelete' on the left, and 'DiffAdd' on
					-- the right.
					if ctx.layout_name:match("^diff2") then
						vim.opt_local.winhl = table.concat({
							"DiffDelete:Whitespace",
						}, ",")
					end
				end
			}
		},
		config = function (_, opts)
			vim.opt.fillchars:append { diff = "╱" }

			require("diffview").setup(opts)
		end
	}
}
