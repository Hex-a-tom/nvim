return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		lazy = true,
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	{
		"https://github.com/neovim/nvim-lspconfig",
		cmd = {'LspInfo', 'LspInstall', 'LspStart'},
		event = {'BufReadPre', 'BufNewFile'},
		dependencies = {
			{'saghen/blink.cmp'},
			{'williamboman/mason-lspconfig.nvim'},
		},
		config = function (_, opts)
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			vim.diagnostic.config({
				underline = true,
				signs = true,
				-- virtual_text = true,
				virtual_text = {
					source = false,
				},
				float = {
					show_header = true,
					source = true,
					border = "border",
					focus = false,
					width = 60,
				},
				update_in_insert = false,
				severity_sort = true,
			})


			-- //////// Lsp Server Config ////////
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			local on_attach = function (_, bufnr)
				lsp_zero.default_keymaps({buffer = bufnr})
			end

			lsp_zero.on_attach(on_attach)

			-- Set up lspconfig.
			local capabilities = require('blink.cmp').get_lsp_capabilities()

			require('lspconfig').ccls.setup {
				capabilities = capabilities,
				init_options = {
					compilationDatabaseDirectory = "build";
					index = {
						threads = 0;
					};
					clang = {
						excludeArgs = { "-frounding-math"} ;
					};
				},
				on_attach = on_attach,
			}

			require('lspconfig').rust_analyzer.setup {
				capabilities = capabilities,
				on_attach = on_attach,
			}

			require("mason-lspconfig").setup({
				ensure_installed = {},
				handlers = {
					lsp_zero.default_setup,
					jdtls = lsp_zero.noop,
				}
			})
		end,
		keys = {
			{"<leader>la", vim.lsp.buf.code_action, desc = "Code Actions"},
			{"<leader>lx", vim.lsp.buf.declaration, desc = "Declaration"},
			{"<leader>ld", "<cmd>Telescope lsp_definitions<CR>", desc = "Definition"},
			{"<leader>li", "<cmd>Telescope lsp_implementations<CR>", desc = "Implementations"},
			{"<leader>ll", vim.lsp.buf.hover, desc = "Hover"},
			{"<leader>lr", "<cmd>Telescope lsp_references<cr>", desc = "References"},
			{"<leader>lt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type Definitions"},
			{"<F2>", vim.lsp.buf.rename, desc = "Rename"},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "VeryLazy",
		config = function ()
			require'nvim-treesitter.configs'.setup {
				-- A list of parser names, or "all"
				ensure_installed = { "c", "lua", "rust"},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				auto_install = true,

				-- List of parsers to ignore installing (for "all")
				ignore_install = {},

				---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
				-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

				highlight = {
					-- `false` will disable the whole extension
					enable = true,

					-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
					-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
					-- the name of the parser)
					-- list of language that will be disabled
					disable = {},

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					-- additional_vim_regex_highlighting = {},
				},
			}
		end,
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		opts = {
			-- options
		},
	},
	{
		"L3MON4D3/LuaSnip",
		version = "2.*",
		build = "make install_jsregexp",
		lazy = true,
		config = function ()
			require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets" })
			require("luasnip.loaders.from_vscode").lazy_load({ exclude = {"rust"}})
		end,
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
	},
	-- cmdline tools and lsp servers
	{
		-- Source: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/init.lua
		"williamboman/mason.nvim",
		lazy = false,
		config = function ()
			require("mason").setup()
		end,
	},
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = 'LuaSnip',

		-- use a release tag to download pre-built binaries
		version = '*',
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			snippets = { preset = 'luasnip' },
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- See the full "keymap" documentation for information on defining your own keymap.
			keymap = {
				preset = 'enter',
				['<Tab>'] = { 'select_next', 'fallback' },
				['<S-Tab>'] = { 'select_prev', 'fallback' },
				['<C-n>'] = { 'snippet_forward', 'fallback' },
				['<C-p>'] = { 'snippet_backward', 'fallback' },
			},

			cmdline = {
				keymap = {
					preset = 'default',
					['<Tab>'] = { 'select_next', 'fallback' },
					['<S-Tab>'] = { 'select_prev', 'fallback' },
				},
				completion = {
					list = {
						selection = {
							preselect = false,
						}
					},
					menu = {
						auto_show = true
					}
				}
			},

			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = false,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = 'mono'
			},

			completion = {
				menu = {
					draw = {
						padding = 0,
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 4 },
						},

						components = {
							kind_icon = {
								text = function(ctx) return " " .. ctx.kind_icon .. ctx.icon_gap .. "  " end,
							}
						}
					}
				},
				list = {
					selection = { preselect = false, auto_insert = true }
				},
				trigger = {
					show_on_keyword = true,
				}
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},
		},
		opts_extend = { "sources.default" },
		config = function(_, opts)
			-- vim.api.nvim_set_hl(0, "PmenuSel", {default = false, bg="#3c3836"})
			-- vim.api.nvim_set_hl(0, "Pmenu", {default = false, bg="#282828"})

			-- vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", {default = false, fg = "#7E8294", strikethrough = true})
			-- vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", {default = false, fg = "#82AAFF",  bold = true})
			-- vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", {default = false, fg = "#82AAFF", bold = true})
			-- vim.api.nvim_set_hl(0, "CmpItemMenu", {default = false, fg = "#C792EA", italic = true})

			vim.api.nvim_set_hl(0, "BlinkCmpKindField", {default = false, fg = "#EED8DA", bg = "#B5585F"})
			vim.api.nvim_set_hl(0, "BlinkCmpKindProperty", {default = false, fg = "#EED8DA", bg = "#B5585F"})
			vim.api.nvim_set_hl(0, "BlinkCmpKindEvent", {default = false, fg = "#EED8DA", bg = "#B5585F"})

			vim.api.nvim_set_hl(0, "BlinkCmpKindText", {default = false, fg = "#C3E88D", bg = "#9FBD73"})
			vim.api.nvim_set_hl(0, "BlinkCmpKindEnum", {default = false, fg = "#C3E88D", bg = "#9FBD73"})
			vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", {default = false, fg = "#C3E88D", bg = "#9FBD73"})

			vim.api.nvim_set_hl(0, "BlinkCmpKindConstant", {default = false, fg = "#FFE082", bg = "#D4BB6C"})
			vim.api.nvim_set_hl(0, "BlinkCmpKindConstructor", {default = false, fg = "#FFE082", bg = "#D4BB6C"})
			vim.api.nvim_set_hl(0, "BlinkCmpKindReference", {default = false, fg = "#FFE082", bg = "#D4BB6C"})

			vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", {default = false, fg = "#EADFF0", bg = "#A377BF"})
			vim.api.nvim_set_hl(0, "BlinkCmpKindStruct", {default = false, fg = "#EADFF0", bg = "#A377BF"})
			vim.api.nvim_set_hl(0, "BlinkCmpKindClass", {default = false, fg = "#EADFF0", bg = "#A377BF"})
			vim.api.nvim_set_hl(0, "BlinkCmpKindModule", {default = false, fg = "#EADFF0", bg = "#A377BF"})
			vim.api.nvim_set_hl(0, "BlinkCmpKindOperator", {default = false, fg = "#EADFF0", bg = "#A377BF"})

			vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", {default = false, fg = "#C5CDD9", bg = "#7E8294"})
			vim.api.nvim_set_hl(0, "BlinkCmpKindFile", {default = false, fg = "#C5CDD9", bg = "#7E8294"})

			vim.api.nvim_set_hl(0, "BlinkCmpKindUnit", {default = false, fg = "#F5EBD9", bg = "#D4A959"})
			vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", {default = false, fg = "#F5EBD9", bg = "#D4A959"})
			vim.api.nvim_set_hl(0, "BlinkCmpKindFolder", {default = false, fg = "#F5EBD9", bg = "#D4A959"})

			vim.api.nvim_set_hl(0, "BlinkCmpKindMethod", {default = false, fg = "#DDE5F5", bg = "#6C8ED4"})
			vim.api.nvim_set_hl(0, "BlinkCmpKindValue", {default = false, fg = "#DDE5F5", bg = "#6C8ED4"})
			vim.api.nvim_set_hl(0, "BlinkCmpKindEnumMember", {default = false, fg = "#DDE5F5", bg = "#6C8ED4"})

			vim.api.nvim_set_hl(0, "BlinkCmpKindInterface", {default = false, fg = "#D8EEEB", bg = "#58B5A8"})
			vim.api.nvim_set_hl(0, "BlinkCmpKindColor", {default = false, fg = "#D8EEEB", bg = "#58B5A8"})
			vim.api.nvim_set_hl(0, "BlinkCmpKindTypeParameter", {default = false, fg = "#D8EEEB", bg = "#58B5A8"})

			require("blink.cmp").setup(opts)
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
		keys = {
			{"<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics"},
			{"<leader>xq", "<cmd>Trouble quickfix toggle<cr>", desc = "Quickfixes"},
			{"<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo"},
			{"gR", "<cmd>Trouble lsp_references toggle<cr>", desc = "Lsp References"},
		},
	},
}
