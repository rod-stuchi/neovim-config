return {
	"rmagatti/goto-preview",
	config = function()
		require("goto-preview").setup({
			width = 120,
			height = 20,
			opacity = 0,
			stack_floating_preview_windows = false,
		})
	end,
}
