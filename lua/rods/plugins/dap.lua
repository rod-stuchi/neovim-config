return {
	"rcarriga/nvim-dap-ui",
	event = "VeryLazy",
	dependencies = {
		"mfussenegger/nvim-dap",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "🛑", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define("DapBreakpointCondition", { text = " ﳁ", texthl = "DapBreakpoint" })
		vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DapBreakpoint" })
		vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "DapLogPoint" })
		vim.fn.sign_define("DapStopped", { text = " ", texthl = "DapStopped" })
		require("rods.plugins.dap.languages").setup()
	end,
}
