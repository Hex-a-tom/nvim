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
			{'hrsh7th/cmp-nvim-lsp'},
			{'williamboman/mason-lspconfig.nvim'},
		},
		config = function ()
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
				update_in_insert = true,
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
			local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
			-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
			local servers = {'bashls'}
			for _, lsp in pairs(servers) do
				require('lspconfig')[lsp].setup {
					capabilities = capabilities,
					on_attach = on_attach
				}
			end

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
				ignore_install = { "javascript" },

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
		"hrsh7th/nvim-cmp",
		-- load cmp on InsertEnter
		event = {
			"InsertEnter",
			"CmdlineEnter",
		},
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"onsails/lspkind.nvim",
			"nvim-lspconfig",
			"LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require'cmp'
			local lspkind = require('lspkind')

			require("luasnip.loaders.from_vscode").lazy_load()
			local luasnip = require("luasnip")

			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			cmp.setup({
				preselect = cmp.PreselectMode.None,
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
					completion = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						col_offset = -3,
						side_padding = 0,
					},
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					['<Tab>'] = cmp.mapping(function (fallback)
						if cmp.visible() then
							cmp.select_next_item()
							-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
							-- they way you will only jump inside the snippet region
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					['<S-Tab>'] = cmp.mapping(function (fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = 'luasnip', priority = 4 }, -- For luasnip users.
					{ name = 'nvim_lsp' },
					-- { name = 'vsnip' }, -- For vsnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
					{ name = "crates" },
					-- { name = "neorg" },
				}, {
					{ name = 'buffer', priority = 0.5 },
				}),
				sorting = {
					comparators = {
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.sort_text,
						cmp.config.compare.recently_used,
						cmp.config.compare.offset,
						cmp.config.compare.kind,
						cmp.config.compare.order,
					}
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"

						return kind
					end,
				},
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
				}, {
					{ name = 'buffer' },
				})
			})

			-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline('/', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				})
			})

			vim.api.nvim_set_hl(0, "PmenuSel", {default = false, bg="#3c3836"})
			vim.api.nvim_set_hl(0, "Pmenu", {default = false, bg="#282828"})

			vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", {default = false, fg = "#7E8294", strikethrough = true})
			vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", {default = false, fg = "#82AAFF",  bold = true})
			vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", {default = false, fg = "#82AAFF", bold = true})
			vim.api.nvim_set_hl(0, "CmpItemMenu", {default = false, fg = "#C792EA", italic = true})

			vim.api.nvim_set_hl(0, "CmpItemKindField", {default = false, fg = "#EED8DA", bg = "#B5585F"})
			vim.api.nvim_set_hl(0, "CmpItemKindProperty", {default = false, fg = "#EED8DA", bg = "#B5585F"})
			vim.api.nvim_set_hl(0, "CmpItemKindEvent", {default = false, fg = "#EED8DA", bg = "#B5585F"})

			vim.api.nvim_set_hl(0, "CmpItemKindText", {default = false, fg = "#C3E88D", bg = "#9FBD73"})
			vim.api.nvim_set_hl(0, "CmpItemKindEnum", {default = false, fg = "#C3E88D", bg = "#9FBD73"})
			vim.api.nvim_set_hl(0, "CmpItemKindKeyword", {default = false, fg = "#C3E88D", bg = "#9FBD73"})

			vim.api.nvim_set_hl(0, "CmpItemKindConstant", {default = false, fg = "#FFE082", bg = "#D4BB6C"})
			vim.api.nvim_set_hl(0, "CmpItemKindConstructor", {default = false, fg = "#FFE082", bg = "#D4BB6C"})
			vim.api.nvim_set_hl(0, "CmpItemKindReference", {default = false, fg = "#FFE082", bg = "#D4BB6C"})

			vim.api.nvim_set_hl(0, "CmpItemKindFunction", {default = false, fg = "#EADFF0", bg = "#A377BF"})
			vim.api.nvim_set_hl(0, "CmpItemKindStruct", {default = false, fg = "#EADFF0", bg = "#A377BF"})
			vim.api.nvim_set_hl(0, "CmpItemKindClass", {default = false, fg = "#EADFF0", bg = "#A377BF"})
			vim.api.nvim_set_hl(0, "CmpItemKindModule", {default = false, fg = "#EADFF0", bg = "#A377BF"})
			vim.api.nvim_set_hl(0, "CmpItemKindOperator", {default = false, fg = "#EADFF0", bg = "#A377BF"})

			vim.api.nvim_set_hl(0, "CmpItemKindVariable", {default = false, fg = "#C5CDD9", bg = "#7E8294"})
			vim.api.nvim_set_hl(0, "CmpItemKindFile", {default = false, fg = "#C5CDD9", bg = "#7E8294"})

			vim.api.nvim_set_hl(0, "CmpItemKindUnit", {default = false, fg = "#F5EBD9", bg = "#D4A959"})
			vim.api.nvim_set_hl(0, "CmpItemKindSnippet", {default = false, fg = "#F5EBD9", bg = "#D4A959"})
			vim.api.nvim_set_hl(0, "CmpItemKindFolder", {default = false, fg = "#F5EBD9", bg = "#D4A959"})

			vim.api.nvim_set_hl(0, "CmpItemKindMethod", {default = false, fg = "#DDE5F5", bg = "#6C8ED4"})
			vim.api.nvim_set_hl(0, "CmpItemKindValue", {default = false, fg = "#DDE5F5", bg = "#6C8ED4"})
			vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", {default = false, fg = "#DDE5F5", bg = "#6C8ED4"})

			vim.api.nvim_set_hl(0, "CmpItemKindInterface", {default = false, fg = "#D8EEEB", bg = "#58B5A8"})
			vim.api.nvim_set_hl(0, "CmpItemKindColor", {default = false, fg = "#D8EEEB", bg = "#58B5A8"})
			vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", {default = false, fg = "#D8EEEB", bg = "#58B5A8"})

		end,
	},
	{
		"folke/trouble.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
		keys = {
			{"<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Touble"},
			{"<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics"},
			{"<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics"},
			{"<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfixes"},
			{"gR", "<cmd>TroubleToggle lsp_references<cr>", desc = "Lsp References"},
		},
	},
}
