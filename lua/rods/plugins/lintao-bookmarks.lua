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

		vim.keymap.set(
			{ "n", "v" },
			"mm",
			"<cmd>BookmarksMark<cr>",
			{ desc = "Mark current line into active BookmarkList." }
		)
		vim.keymap.set(
			{ "n", "v" },
			"mo",
			"<cmd>BookmarksGoto<cr>",
			{ desc = "Go to bookmark at current active BookmarkList" }
		)
		vim.keymap.set(
			{ "n", "v" },
			"ma",
			"<cmd>BookmarksCommands<cr>",
			{ desc = "Find and trigger a bookmark command." }
		)
		vim.keymap.set(
			{ "n", "v" },
			"mg",
			"<cmd>BookmarksGotoRecent<cr>",
			{ desc = "Go to latest visited/created Bookmark" }
		)
		vim.keymap.set(
			{ "n", "v" },
			"mt",
			"<cmd>BookmarksTree<cr>",
			{ desc = "Open BookmarkTree" }
		)
	end,
}
