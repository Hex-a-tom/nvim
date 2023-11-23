return {
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
				tools = {
					executor = require("rust-tools.executors").toggleterm,
				},
				on_initialized = function(health)
					vim.notify("Started rust-analyzer with status: " .. health)
				end,
				server = {
					on_attach = function(client, bufnr)
						-- Hover actions
						vim.keymap.set("n", "<leader>ll", rt.hover_actions.hover_actions, { buffer = bufnr })
						-- Code action groups
						vim.keymap.set("n", "<Leader>la", rt.code_action_group.code_action_group, { buffer = bufnr })
						vim.keymap.set("n", "<Leader>lR", "<cmd>RustRunnables<cr>", { buffer = bufnr, desc = "Run" })
						vim.keymap.set("n", "<Leader>lc", rt.open_cargo_toml.open_cargo_toml, { buffer = bufnr, desc = "Open Config" })
						vim.keymap.set("n", "<Leader>ls", "<cmd>!rustup doc std<cr><cr>", { buffer = bufnr, desc = "Std Documentation", silent = true })
						vim.keymap.set("n", "<Leader>lD", '<cmd>!xdg-open "https://docs.rs/"<cr><cr>', { buffer = bufnr, desc = "Documentation", silent = true })
						require("nvim-navic").attach(client, bufnr)
					end,
					capabilities = capabilities,
				},
			})
		end,
		dependencies = {
			"nvim-cmp",
			"nvim-navic"
		}
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		tag = "v0.4.0",
		config = function ()
			local crates = require('crates')
			crates.setup()
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
}
