return {
	"MattesGroeger/vim-bookmarks",
	event = "BufEnter",
	config = function()
		vim.cmd([[
			highlight BookmarkSign ctermbg=NONE ctermfg=160
			highlight BookmarkLine ctermbg=194 ctermfg=NONE
			let g:bookmark_sign = '🏁'
			let g:bookmark_annotation_sign = '🚩'
			let g:bookmark_highlight_lines = 1
			let g:bookmark_save_per_working_dir = 1
			let g:bookmark_auto_save = 1
			let g:bookmark_center = 1
			let g:bookmark_show_warning = 1
			let g:bookmark_show_toggle_warning = 1
			let g:bookmark_display_annotation = 1
			let g:bookmark_no_default_key_mappings = 1
		]])

		local keymap = vim.keymap.set
		keymap('n', 'mm', '<cmd>BookmarkToggle<cr>', { desc = 'bookmark toggle' })
		keymap('n', 'ml', '<cmd>BookmarkLoad .vim-bookmarks<cr>', { desc = 'bookmark load .vim-bookmarks' })
		keymap('n', 'mi', '<cmd>BookmarkAnnotate<cr>', { desc = 'bookmark annotate' })
		keymap('n', 'mn', '<cmd>BookmarkNext<cr>', { desc = 'bookmark next' })
		keymap('n', 'mp', '<cmd>BookmarkPrev<cr>', { desc = 'bookmark previous' })
		keymap('n', 'ma', '<cmd>BookmarkShowAll<cr>', { desc = 'bookmark list' })
		keymap('n', 'mc', '<cmd>BookmarkClear<cr>', { desc = 'bookmark clear' })
		keymap('n', 'mx', '<cmd>BookmarkClearAll<cr>', { desc = 'bookmark clear all' })
		keymap('n', 'mg', ':BookmarkMoveToLine ', { desc = 'bookmark move to line:' })
		keymap('n', 'mkk', '<cmd>BookmarkMoveUp 1<cr>', { desc = 'bookmark move up 1' })
		keymap('n', 'mjj', '<cmd>BookmarkMoveDown 1<cr>', { desc = 'bookmark down up 1' })
	end,
}
