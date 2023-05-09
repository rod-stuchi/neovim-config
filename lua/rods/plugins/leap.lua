return {
	-- alternative to: https://github.com/ggandor/lightspeed.nvim
	"ggandor/leap.nvim",
	dependencies = {
		-- plugins for leap
		"ggandor/flit.nvim",
	},
	config = function()
		require("leap").add_default_mappings()
		require("flit").setup({
			keys = { f = "f", F = "F", t = "t", T = "T" },
			-- A string like "nv", "nvo", "o", etc.
			labeled_modes = "v",
			multiline = false,
			opts = {},
		})
	end,
}
