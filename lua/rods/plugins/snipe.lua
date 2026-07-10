return {
	"leath-dub/snipe.nvim",
	-- No longer used; kept installed but dormant. Its former `,<space>` keymap
	-- is now reused for mini.files (see which-key.lua). Invoke manually with
	-- :lua require("snipe").open_buffer_menu() if ever needed.
	lazy = true,
	ui = {
		preselect_current = true,
	},
	opts = {
		hints = {
			-- Charaters to use for hints (NOTE: make sure they don't collide with the navigation keymaps)
			dictionary = "asdfglewcmpghio",
		},
	},
}
