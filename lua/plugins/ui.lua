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
				lualine_y = {
					{
						function() return require("noice").api.status.command.get() end,
						cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
					},
					{
						function() return require("noice").api.status.mode.get() end,
						cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
					},
					{
							function() return " " .. require("dap").status() end,
							cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
					},
					'location',
				},
				lualine_z = {
					{
						'datetime',
						style = '%H:%M'
					},
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = { fg = "#ff9e64", bg = "#1e2030" },
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
		"norcalli/nvim-colorizer.lua",
		opts = {
			'css';
			'javascript';
			html = {
				mode = 'foreground';
			}
		},
		cmd = "ColorizerToggle",
		ft = {
			"css",
			"javascript",
			"html",
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
		-- TODO: Fix error when exit last non terminal window
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
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		opts = {
			options = {
				separator_style = "slant",
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(_, _, diag)
						local ret = (diag.error and " " .. diag.error .. " " or "")
						.. (diag.warning and " " .. diag.warning or "")
						return vim.trim(ret)
				end,
			},
		},
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
			{"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files"},
			{"<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep"},
			{"<leader>fb", "<cmd>Telescope file_browser<cr>", desc = "File Browser"},
			{"<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Helpfiles"},
			{"<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Oldfiles"},
			{"<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo"},
			{"<leader>p", "<cmd>Telescope neoclip<cr>", desc = "Neoclip"},
			{"<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects"},
			{"<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{"<leader>fB", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{"<leader>fa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
			{"<leader>xD", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
			{"<leader>xW", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
			{"<leader>fm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
			{"<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume" },
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
