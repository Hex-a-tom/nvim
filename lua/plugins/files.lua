return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		keys = {
			{ "<leader>of", "<cmd>NvimTreeOpen<cr>", desc = "Nvim-Tree" },
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local api = require "nvim-tree.api"
			local function set_root()
				api.tree.change_root_to_node(api.tree.get_node_under_cursor())
			end

			local function my_on_attach(bufnr)

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- custom mappings
				vim.keymap.set('n', '<C-t>', set_root,             opts('Set Root'))
				vim.keymap.set('n', '?',     api.tree.toggle_help, opts('Help'))
			end

			local HEIGHT_RATIO = 0.8  -- You can change this
			local WIDTH_RATIO = 0.5   -- You can change this too

			require('nvim-tree').setup({
				on_attach = my_on_attach,
				view = {
					number = false,
					relativenumber = false,
					float = {
						enable = true,
						open_win_config = function()
							local screen_w = vim.opt.columns:get()
							local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
							local window_w = screen_w * WIDTH_RATIO
							local window_h = screen_h * HEIGHT_RATIO
							local window_w_int = math.floor(window_w)
							local window_h_int = math.floor(window_h)
							local center_x = (screen_w - window_w) / 2
							local center_y = ((vim.opt.lines:get() - window_h) / 2)
							- vim.opt.cmdheight:get()
							return {
								border = 'rounded',
								relative = 'editor',
								row = center_y,
								col = center_x,
								width = window_w_int,
								height = window_h_int,
							}
						end,
					},
					width = function()
						return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
					end,
				},
				renderer = {
					icons = {
						glyphs = {
							git = {
								unstaged = "✖",
								staged = "",
								untracked = "",
								ignored = "",
								renamed = "",
								deleted = "",
								unmerged = "",
							},
						},
					},
				},
			})
		end,
	},
	{
		'stevearc/oil.nvim',
		opts = {
			keymaps = {
				["q"] = "actions.close",
			}
		},
		cmd = "Oil",
		keys = {
			{ "<leader>fb", "<cmd>Oil<cr>", desc = "File browser (Oil)" },
			{ "<leader>oo", "<cmd>Oil<cr>", desc = "Oil" },
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}

