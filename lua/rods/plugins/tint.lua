return {
	"levouh/tint.nvim",
	config = function()
		require("tint").setup({
			tint = -45, -- Darken colors, use a positive value to brighten
			saturation = 0.4, -- Saturation to preserve
		})
	end,
}
