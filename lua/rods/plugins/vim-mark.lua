return {
	"inkarkat/vim-mark",
	dependencies = "inkarkat/vim-ingo-library",
	init = function()
		vim.g["mwDefaultHighlightingPalette"] = "extended"
		vim.g["mwDefaultHighlightingPalette"] = "maximum"
		vim.g["mwDefaultHighlightingNum"] = 30
	end,
	config = function()
		vim.keymap.set("n", "<leader>m", "<nop>")
		vim.keymap.set("n", "<leader>n", "<nop>")
		vim.keymap.set("n", "<leader>r", "<nop>")
		vim.keymap.set("n", "<leader>#", "<nop>")
		vim.keymap.set("n", "<leader>*", "<nop>")
		vim.keymap.set("n", "<leader>/", "<nop>")
		vim.keymap.set("n", "<leader>?", "<nop>")

		vim.keymap.set({ "n", "x" }, ",m", "<plug>MarkSet")
		vim.keymap.set("n", ",M", "<plug>MarkToggle")
		vim.keymap.set("n", ",N", "<plug>MarkAllClear")
		vim.keymap.set("n", ",#", "<plug>MarkSearchOrCurPrev")
		vim.keymap.set("n", ",*", "<plug>MarkSearchOrCurNext")
		vim.keymap.set("n", ",(", "<plug>MarkSearchOrAnyPrev")
		vim.keymap.set("n", ",)", "<plug>MarkSearchOrAnyNext")
		vim.keymap.set("n", ",[", "<plug>MarkSearchAnyOrDefaultPrev")
		vim.keymap.set("n", ",]", "<plug>MarkSearchAnyOrDefaultNext")
	end,
}
