return {
	{
		-- TODO: Stop from opening when no executable is selected
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
		},
		config = function ()
			-- TODO: include meson debuggers
			local dap = require('dap')
			dap.adapters.lldb = {
				type = 'executable',
				command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
				name = 'lldb'
			}

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

			dap.configurations.cpp = {
				{
					name = 'Launch',
					type = 'lldb',
					request = 'launch',
					-- TODO: fix program selection function
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
					end,
					cwd = '${workspaceFolder}',
					stopOnEntry = false,
					args = {},

					-- 💀
					-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
					--
					--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
					--
					-- Otherwise you might get the following error:
					--
					--    Error on launch: Failed to attach to the target process
					--
					-- But you should be aware of the implications:
					-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
					-- runInTerminal = false,
				},
			}

			-- If you want to use this for Rust and C, add something like this:

			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp

		end
	},
}
