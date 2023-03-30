return {
	{
		"folke/neodev.nvim",
		ft = "lua",
		config = function ()
			local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

			local on_attach = function(client, bufnr)
				if client.server_capabilities.documentSymbolProvider then
					require("nvim-navic").attach(client, bufnr)
				end
			end

			require('lspconfig').lua_ls.setup {
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
							version = 'LuaJIT',
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = {'vim'},
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
						},
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = {
							enable = false,
						},
					},
				},
				on_attach = on_attach,
			}
		end,
		dependencies = {
			"nvim-cmp"
		}
	},
	{
		"simrat39/rust-tools.nvim",
		ft = {
			"rust",
			"toml",
		},
		config = function ()
			local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

			local rt = require("rust-tools")

			rt.setup({
				on_initialized = function(health)
					vim.notify("Started rust-analyzer with status: " .. health)
				end,
				server = {
					on_attach = function(client, bufnr)
						-- Hover actions
						vim.keymap.set("n", "<leader>ll", rt.hover_actions.hover_actions, { buffer = bufnr })
						-- Code action groups
						vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
						require("nvim-navic").attach(client, bufnr)
					end,
					capabilities = capabilities,
				},
			})
		end,
		dependencies = {
			"nvim-cmp"
		}
	},
	{
		"saecki/crates.nvim",
		ft = "toml",
		version = "0.3.0",
		config = function ()
			local crates = require('crates')
			local opts = { noremap = true, silent = true }

			vim.keymap.set('n', '<leader>ct', crates.toggle, opts)
			vim.keymap.set('n', '<leader>cr', crates.reload, opts)

			vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, opts)
			vim.keymap.set('n', '<leader>cf', crates.show_features_popup, opts)
			vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, opts)

			vim.keymap.set('n', '<leader>cu', crates.update_crate, opts)
			vim.keymap.set('v', '<leader>cu', crates.update_crates, opts)
			vim.keymap.set('n', '<leader>ca', crates.update_all_crates, opts)
			vim.keymap.set('n', '<leader>cU', crates.upgrade_crate, opts)
			vim.keymap.set('v', '<leader>cU', crates.upgrade_crates, opts)
			vim.keymap.set('n', '<leader>cA', crates.upgrade_all_crates, opts)

			vim.keymap.set('n', '<leader>cH', crates.open_homepage, opts)
			vim.keymap.set('n', '<leader>cR', crates.open_repository, opts)
			vim.keymap.set('n', '<leader>cD', crates.open_documentation, opts)
			vim.keymap.set('n', '<leader>cC', crates.open_crates_io, opts)
		end,
		dependencies = {
			"nvim-lua/plenary.nvim"
		}
	},
	{
		"https://github.com/neovim/nvim-lspconfig",
		lazy = true,
		dependencies = {
			"neodev.nvim"
		},
		config = function ()
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			local opts = {silent = true, noremap = true}

			vim.keymap.set('n', '<leader>lx', vim.lsp.buf.declaration, opts)
			vim.keymap.set('n', '<leader>ld', '<cmd>Telescope lsp_definitions<CR>', opts)
			vim.keymap.set('n', '<leader>li', '<cmd>Telescope lsp_implementations<CR>', opts)
			vim.keymap.set('n', '<leader>ll', vim.lsp.buf.hover, opts)
			vim.keymap.set('n', '<leader>lr', '<cmd>Telescope lsp_references<CR>', opts)
			vim.keymap.set('n', '<leader>lt', '<cmd>Telescope lsp_type_definitions<CR>', opts)
			vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
		end,
		keys = {
			{"<leader>l", desc = "Lsp"}
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "VeryLazy",
		config = function ()
			require'nvim-treesitter.configs'.setup {
				-- A list of parser names, or "all"
				ensure_installed = { "c", "lua", "rust", "scala", "c_sharp" },

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
					additional_vim_regex_highlighting = {'org'},
				},
			}
		end
	},
	{
		"j-hui/fidget.nvim",
		config = true,
		event = "InsertEnter",
	},
	{
		"L3MON4D3/LuaSnip",
		version = "1.*",
		build = "make install_jsregexp",
		lazy = true,
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"SmiteshP/nvim-navic",
		opts = {
			separator = "  "
		},
		lazy = true,
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
			"nvim-navic",
		},
		config = function()
			local cmp = require'cmp'
			local lspkind = require('lspkind')

			require("luasnip.loaders.from_vscode").lazy_load()

			cmp.setup({
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
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					-- { name = 'vsnip' }, -- For vsnip users.
					{ name = 'luasnip' }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
					{ name = "crates" },
					{ name = "neorg" },
				}, {
					{ name = 'buffer' },
				}),
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

			local on_attach = function(client, bufnr)
				if client.server_capabilities.documentSymbolProvider then
					require("nvim-navic").attach(client, bufnr)
				end
			end

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

			require('lspconfig').omnisharp.setup{
				capabilities = capabilities,
				cmd = {"omnisharp"},
				on_attach = on_attach
			}

			vim.cmd([[
			highlight! PmenuSel guibg=#282C34 guifg=NONE
			highlight! Pmenu guifg=#C5CDD9 guibg=#22252A

			highlight! CmpItemAbbrDeprecated guifg=#7E8294 guibg=NONE cterm=strikethrough
			highlight! CmpItemAbbrMatch guifg=#82AAFF guibg=NONE cterm=bold
			highlight! CmpItemAbbrMatchFuzzy guifg=#82AAFF guibg=NONE cterm=bold
			highlight! CmpItemMenu guifg=#C792EA guibg=NONE" cterm=italic

			highlight! CmpItemKindField guifg=#EED8DA guibg=#B5585F
			highlight! CmpItemKindProperty guifg=#EED8DA guibg=#B5585F
			highlight! CmpItemKindEvent guifg=#EED8DA guibg=#B5585F

			highlight! CmpItemKindText guifg=#C3E88D guibg=#9FBD73
			highlight! CmpItemKindEnum guifg=#C3E88D guibg=#9FBD73
			highlight! CmpItemKindKeyword guifg=#C3E88D guibg=#9FBD73

			highlight! CmpItemKindConstant guifg=#FFE082 guibg=#D4BB6C
			highlight! CmpItemKindConstructor guifg=#FFE082 guibg=#D4BB6C
			highlight! CmpItemKindReference guifg=#FFE082 guibg=#D4BB6C

			highlight! CmpItemKindFunction guifg=#EADFF0 guibg=#A377BF
			highlight! CmpItemKindStruct guifg=#EADFF0 guibg=#A377BF
			highlight! CmpItemKindClass guifg=#EADFF0 guibg=#A377BF
			highlight! CmpItemKindModule guifg=#EADFF0 guibg=#A377BF
			highlight! CmpItemKindOperator guifg=#EADFF0 guibg=#A377BF

			highlight! CmpItemKindVariable guifg=#C5CDD9 guibg=#7E8294
			highlight! CmpItemKindFile guifg=#C5CDD9 guibg=#7E8294

			highlight! CmpItemKindUnit guifg=#F5EBD9 guibg=#D4A959
			highlight! CmpItemKindSnippet guifg=#F5EBD9 guibg=#D4A959
			highlight! CmpItemKindFolder guifg=#F5EBD9 guibg=#D4A959

			highlight! CmpItemKindMethod guifg=#DDE5F5 guibg=#6C8ED4
			highlight! CmpItemKindValue guifg=#DDE5F5 guibg=#6C8ED4
			highlight! CmpItemKindEnumMember guifg=#DDE5F5 guibg=#6C8ED4

			highlight! CmpItemKindInterface guifg=#D8EEEB guibg=#58B5A8
			highlight! CmpItemKindColor guifg=#D8EEEB guibg=#58B5A8
			highlight! CmpItemKindTypeParameter guifg=#D8EEEB guibg=#58B5A8
			]])

		end,
	},
	{
		"folke/trouble.nvim",
		config = function ()
			local opts = {silent = true, noremap = true}
			vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', opts)
			vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts)
			vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', opts)
			vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', opts)
			vim.keymap.set('n', 'gR', '<cmd>TroubleToggle lsp_references<cr>', opts)
		end,
		keys = {
			{"<leader>x", desc = "Trouble"}
		},
	},
}
