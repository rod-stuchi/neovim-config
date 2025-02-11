return {
	"LintaoAmons/bookmarks.nvim",
	event = "BufEnter",
	dependencies = {
		{ "kkharji/sqlite.lua" },
		{ "nvim-telescope/telescope.nvim" },
		{ "stevearc/dressing.nvim" }, -- optional: better UI
	},
	config = function()
		-- telescope re-mappings
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},
		})
		-- telescope re-mappings [end]
		vim.keymap.set("n", "<M-,>", "<cmd>BookmarksGotoPrev<cr>")
		vim.keymap.set("n", "<M-.>", "<cmd>BookmarksGotoNext<cr>")
		vim.keymap.set("n", "<M-<>", "<cmd>BookmarksGotoPrevInList<cr>")
		vim.keymap.set("n", "<M->>", "<cmd>BookmarksGotoNextInList<cr>")

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
