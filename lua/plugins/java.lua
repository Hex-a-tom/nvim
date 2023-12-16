
local function java_attach(opts, buf)
	opts.root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})
	require('jdtls').start_or_attach(opts)
	vim.keymap.set('n', 'lp', '<cmd>echo "hello"<cr>', { buffer = buf })
	require("which-key").register({
		l = {
			o = { require("jdtls").organize_imports, "(jdtls) Organize imports" }
		},
		d = {
			c = { require("jdtls").test_class, "(jdtls) Test Class" }
		}
	}, { prefix = "<leader>", buffer = buf })
end

local function build_bundles()
	local bundles = {
		vim.fn.glob(
			vim.fn.stdpath('data') .. '/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar',
			true
		),
	}

	vim.list_extend(bundles, vim.split(
		vim.fn.glob(
			vim.fn.stdpath('data') .. '/mason/packages/java-test/extension/server/*.jar',
			true
		),
		"\n"
	))

	return bundles
end

return {
	"mfussenegger/nvim-jdtls",
	ft = {
		"java",
	},
	dependencies = {
		"nvim-dap"
	},
	opts = {
		cmd = { vim.fn.stdpath('data') .. '/mason/bin/jdtls' },

		-- Here you can configure eclipse.jdt.ls specific settings
		-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
		-- for a list of options
		settings = {
			java = {
				configuration = {
					runtimes = {
						{
							name = "JavaSE-17",
							path = "/usr/lib/jvm/java-17-openjdk/",
						},
					}
				}
			}
		},

		-- Language server `initializationOptions`
		-- You need to extend the `bundles` with paths to jar files
		-- if you want to use additional eclipse.jdt.ls plugins.
		--
		-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
		--
		-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
		init_options = {
			bundles = build_bundles()
		},
	},
	config = function (_, opts)
		-- java_attach(opts, vim.api.nvim_get_current_buf())
		-- vim.notify(tostring(vim.api.nvim_get_current_buf()))
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("lsp_java_attach", { clear = true }),
			pattern = { "java" },
			callback = function(ev)
				java_attach(opts, ev.buf)
			end,
		})
	end
}
