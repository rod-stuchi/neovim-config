return {
	"smjonas/live-command.nvim",
	config = function()
		require("live-command").setup({
			commands = {
				Norm = { cmd = "norm" },
				Reg = {
					cmd = "norm",
				},
			},
		})
	end,
}
