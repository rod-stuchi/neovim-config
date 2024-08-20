return {
	"LintaoAmons/bookmarks.nvim",
	event = "BufEnter",
	dependencies = {
		{ "stevearc/dressing.nvim" }, -- optional: to have the same UI shown in the GIF
	},
	config = function()
		local opts = {
			-- This is how the sign looks.
			signs = {
				mark = { icon = "󰃁", color = "red", line_bg = "#572626" },
			},
			picker = {
				-- choose built-in sort logic by name: string, find all the sort logics in `bookmarks.adapter.sort-logic`
				-- or custom sort logic: function(bookmarks: Bookmarks.Bookmark[]): nil
				sort_by = "created_at",
			},
		}
		require("bookmarks").setup(opts)
	end,
}
