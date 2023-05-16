return {
	"folke/trouble.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("trouble").setup({
			auto_open = false, -- automatically open the list when you have diagnostics
			auto_close = false, -- automatically close the list when you have no diagnostics
			auto_preview = false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
		})
	end,
}
