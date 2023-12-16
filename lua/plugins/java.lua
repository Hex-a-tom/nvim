return {
	"mfussenegger/nvim-jdtls",
	ft = {
		"java",
	},
	opts = {
		cmd = { vim.fn.stdpath('data') .. '/mason/bin/jdtls' },

		-- Here you can configure eclipse.jdt.ls specific settings
		-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
		-- for a list of options
		settings = {
			java = {
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
			bundles = {}
		},
	},
	config = function (_, opts)
		opts.root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})
		require('jdtls').start_or_attach(opts)
	end
}