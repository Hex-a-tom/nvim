return {
	"RRethy/vim-illuminate",
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		init = function ()
			vim.cmd[[
				let g:tmux_navigator_no_mappings = 1
			]]
		end,
		config = function ()
			-- Navigation
			vim.keymap.set({"n", "t", "i"}, "<A-h>", "<cmd>TmuxNavigateLeft<cr>", {silent = true})
			vim.keymap.set({"n", "t", "i"}, "<A-j>", "<cmd>TmuxNavigateDown<cr>", {silent = true})
			vim.keymap.set({"n", "t", "i"}, "<A-k>", "<cmd>TmuxNavigateUp<cr>", {silent = true})
			vim.keymap.set({"n", "t", "i"}, "<A-l>", "<cmd>TmuxNavigateRight<cr>", {silent = true})
		end
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
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		dependencies = {
			"nvim-cmp"
		},
		opts = { -- this is equalent to setup({}) function
			check_ts = true,
			enable_check_bracket_line = true,
			ignored_next_char = "[%ws%.]",
		},
		config = function (_ , setup)
			local npairs = require("nvim-autopairs")
			npairs.setup(setup)

			local Rule = require('nvim-autopairs.rule')
			local cond = require('nvim-autopairs.conds')

			-- ////// Custom rules //////

			npairs.add_rules({
				Rule('r#"', '"#', {"rust", "rs"})
			})

			npairs.add_rules({
				Rule('<', '>', {"rust", "rs"})
			})

			local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
			npairs.add_rules {
				-- Rule for a pair with left-side ' ' and right side ' '
				Rule(' ', ' ')
				-- Pair will only occur if the conditional function returns true
				:with_pair(function(opts)
					-- We are checking if we are inserting a space in (), [], or {}
					local pair = opts.line:sub(opts.col - 1, opts.col)
					return vim.tbl_contains({
						brackets[1][1] .. brackets[1][2],
						brackets[2][1] .. brackets[2][2],
						brackets[3][1] .. brackets[3][2]
					}, pair)
				end)
				:with_move(cond.none())
				:with_cr(cond.none())
				-- We only want to delete the pair of spaces when the cursor is as such: ( | )
				:with_del(function(opts)
					local col = vim.api.nvim_win_get_cursor(0)[2]
					local context = opts.line:sub(col - 1, col + 2)
					return vim.tbl_contains({
						brackets[1][1] .. '  ' .. brackets[1][2],
						brackets[2][1] .. '  ' .. brackets[2][2],
						brackets[3][1] .. '  ' .. brackets[3][2]
					}, context)
				end)
			}
			-- For each pair of brackets we will add another rule
			for _, bracket in pairs(brackets) do
				npairs.add_rules {
					-- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
					Rule(bracket[1] .. ' ', ' ' .. bracket[2])
					:with_pair(cond.none())
					:with_move(function(opts) return opts.char == bracket[2] end)
					:with_del(cond.none())
					:use_key(bracket[2])
					-- Removes the trailing whitespace that can occur without this
					:replace_map_cr(function(_) return '<C-c>2xi<CR><C-c>O' end)
				}
			end

			for _,punct in pairs { ",", ";" } do
				npairs.add_rules {
					Rule("", punct)
					:with_move(function(opts) return opts.char == punct end)
					:with_pair(function() return false end)
					:with_del(function() return false end)
					:with_cr(function() return false end)
					:use_key(punct)
				}
			end

			-- If you want insert `(` after select function or method item
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			local cmp = require('cmp')
			cmp.event:on(
				'confirm_done',
				cmp_autopairs.on_confirm_done()
			)
		end
	},
	{
		"cohama/lexima.vim",
		event = "InsertEnter",
		enabled = false,
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
