return {
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		keys = {
			{"<leader>du", "<cmd>lua require'dapui'.toggle<CR>", desc = "Toggle debug ui"},
			{"<leader>di", "<cmd>lua require'dapui'.eval<CR>", desc = "Eval"},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end
	},
	{
		"mfussenegger/nvim-dap",
		keys = {
			{"<F5>", "<cmd>lua require'dap'.continue()<CR>", desc = "Continue"},
			{"<F10>", "<cmd>lua require'dap'.step_over()<CR>", desc = "Step over"},
			{"<F11>", "<cmd>lua require'dap'.step_into()<CR>", desc = "Step into"},
			{"<F12>", "<cmd>lua require'dap'.step_out()<CR>", desc = "Step out"},
			{"<leader>dd", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle breakpoint"},
			{"<leader>db", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))", desc = "Set breakpoint"},
			{"<leader>dp", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))", desc = "Set breakpoint"},
			{"<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", desc = "Debug repl"},
			{"<leader>dl", "<cmd>lua require'dap'.run_last()<CR>", desc = "Run last"},
		},
		dependencies = {
			"nvim-dap-ui",
			-- mason.nvim integration
			{
				"jay-babu/mason-nvim-dap.nvim",
				dependencies = "mason.nvim",
				cmd = { "DapInstall", "DapUninstall" },
				opts = {
					-- Makes a best effort to setup the various debuggers with
					-- reasonable debug configurations
					automatic_setup = true,

					-- You can provide additional configuration to the handlers,
					-- see mason-nvim-dap README for more information
					handlers = {},

					-- You'll need to check that you have the required things installed
					-- online, please don't ask me how to install them :)
					ensure_installed = {
						"cpptools"
					},
				},
			},
		},
		config = function ()
			local icons = {
				Stopped = { " ", "DiagnosticWarn", "DapStoppedLine" },
				Breakpoint = " ",
				BreakpointCondition = " ",
				BreakpointRejected = { " ", "DiagnosticError" },
				LogPoint = ".>",
			}
			for name, sign in pairs(icons) do
				sign = type(sign) == "table" and sign or { sign }
				vim.fn.sign_define(
				"Dap" .. name,
				{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
				)
			end
		end
	},
	-- cmdline tools and lsp servers
	{
		-- Source: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/init.lua
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = {
			ensure_installed = {
				-- "stylua",
				-- "shfmt",
				-- "flake8",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
}
