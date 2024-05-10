return {
	"LintaoAmons/bookmarks.nvim",
	event = "BufEnter",
	dependencies = {
		{ "stevearc/dressing.nvim" }, -- optional: to have the same UI shown in the GIF
	},
	config = function()
		require("bookmarks").setup({
			json_db_path = vim.fs.normalize(vim.fn.stdpath("config") .. "/bookmarks.db.json"),
			signs = {
				mark = { icon = "", color = "#ff4c34" },
			},
		})

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
	end,
}
