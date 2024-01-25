local M = {}
function M.setup()
	local dap = require("dap")

	-- Rust
	dap.adapters.codelldb = {
		type = "server",
		port = "13000",
		executable = {
			command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/codelldb",
			args = { "--port", "13000" },
		},
	}

	-- Node
	dap.adapters["pwa-node"] = {
		type = "server",
		host = "localhost",
		port = "13001",
		pid = require("dap.utils").pick_process,
		executable = {
			command = "node",
			-- 💀 Make sure to update this path to point to your installation
			args = {
				vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
				"13001",
			},
		},
	}

	dap.adapters.chrome = {
		type = "executable",
		command = "node",
		args = { vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapter/src/chromeDebug.ts" }, -- TODO adjust
	}

	dap.configurations.rust = {
		{
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
		},
	}

	dap.configurations.javascript = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
	}
	dap.configurations.typescript = dap.configurations.javascript

	dap.configurations.typescriptreact = {
		{
			type = "chrome",
			request = "attach",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			port = 9222,
			webRoot = "${workspaceFolder}",
		},
	}
	dap.configurations.javascriptreact = dap.configurations.typescriptreact
end

return M
