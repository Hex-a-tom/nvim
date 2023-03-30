return {
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				globalstatus = true,
			},
			sections = {
				lualine_c = {
					{
						function()
							return require("nvim-navic").get_location()
						end,
						cond = function()
							return require("nvim-navic").is_available()
						end
					},
				},
				lualine_y = { 'location' },
				lualine_z = {
					{
						'datetime',
						style = '%H:%M'
					},
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = { fg = "#ff9e64" },
					},
				},
			},
			extensions = {
				'lazy',
				'trouble',
				'toggleterm',
				'nvim-dap-ui',
			},
		},
		dependencies = {
			"nvim-navic",
			"nvim-tree/nvim-web-devicons",
		}
	},
	{
		"b0o/incline.nvim",
		opts = {
			window = {
				margin = {
					horizontal = 0,
					vertical = 0,
				}
			}
		},
		event = "VeryLazy",
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			open_mapping = [[<F4>]],
		},
		keys = {
			{"<F4>"}
		}
	},
	{
		"ziontee113/icon-picker.nvim",
		opts = {
			disable_legacy_commands = true,
		},
		dependencies = {
			"telescope.nvim",
		},
		keys = {
			{"<leader>i", "<cmd>IconPickerNormal<cr>", desc = "Icon Picker"}
		},
	},
	{
		"rcarriga/nvim-notify",
		config = function ()
			vim.notify = require("notify")
		end,
	},
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim"
		},
		opts = {
			cmdline = {
				view = "cmdline",
			},
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		}
	},
	{
		"romgrk/barbar.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			-- lazy.nvim can automatically call setup for you. just put your options here:
			-- insert_at_start = true,
			-- animation = true,
			-- …etc
		},
		version = '^1.0.0', -- optional: only update when a new 1.x version is released
		config = function ()
			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }

			-- Move to previous/next
			map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
			map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
			-- Re-order to previous/next
			map('n', '<A-C-,>', '<Cmd>BufferMovePrevious<CR>', opts)
			map('n', '<A-C-.>', '<Cmd>BufferMoveNext<CR>', opts)
			-- Goto buffer in position...
			map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
			map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
			map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
			map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
			map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
			map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
			map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
			map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
			map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
			map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
			-- Pin/unpin buffer
			map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
			-- Close buffer
			map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
			-- Wipeout buffer
			--                 :BufferWipeout
			-- Close commands
			--                 :BufferCloseAllButCurrent
			--                 :BufferCloseAllButPinned
			--                 :BufferCloseAllButCurrentOrPinned
			--                 :BufferCloseBuffersLeft
			--                 :BufferCloseBuffersRight
			-- Magic buffer-picking mode
			map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
			-- Sort automatically by...
			map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
			map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
			map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
			map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
		end
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		lazy = true,
	},
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.*",
		cmd = "Telescope",
		keys = {
			{"<leader>f", desc = "Find (Telescope)"}
		},
		dependencies = {
			"BurntSushi/ripgrep",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"telescope-fzf-native.nvim",
			"nvim-lua/plenary.nvim",
			"project.nvim",
			"nvim-neoclip.lua",
		},
		init = function ()
			local opts = {silent = true, noremap = true}
			vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
			vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
			vim.keymap.set('n', '<leader>fb', '<cmd>Telescope file_browser<cr>', opts)
			vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)
			vim.keymap.set('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>', opts)
			vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', opts)
			vim.keymap.set('n', '<leader>p', '<cmd>Telescope neoclip<cr>', opts)
			vim.keymap.set('n', '<leader>fp', '<cmd> Telescope projects<cr>', opts)
		end,
		config = function ()
			local telescope = require("telescope")

			telescope.setup {
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown {

						}
					},
					["fzf"] = {
						fuzzy = true,                    -- false will only do exact matching
						override_generic_sorter = true,  -- override the generic sorter
						override_file_sorter = true,     -- override the file sorter
						case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					}
				}
			}

			telescope.load_extension('projects')
			telescope.load_extension('neoclip')
			telescope.load_extension "file_browser"
			telescope.load_extension("ui-select")
			telescope.load_extension('fzf')
		end
	}
}
