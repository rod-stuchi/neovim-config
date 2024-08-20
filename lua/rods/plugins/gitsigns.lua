return {
	"lewis6991/gitsigns.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/which-key.nvim",
	},
	config = function()
		local wk = require("which-key")
		require("gitsigns").setup({
            -- stylua: ignore
            signs = {
                add          = { text = "│" },
                change       = { text = "│" },
                delete       = { text = "_" },
                topdelete    = { text = "‾" },
                changedelete = { text = "~" },
                untracked    = { text = "┆" },
            },
			-- stylua: ignore start
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			-- stylua: ignore end
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")

				local _icon = { icon = "", color = "red" }
				wk.add({
					{ "<leader>h", group = "Gitsigns", icon = _icon },
					{ "<leader>hs", gs.stage_hunk, desc = "stage hunk" },
					{ "<leader>hr", gs.reset_hunk, desc = "reset hunk" },
					{ "<leader>eq", "<cmd>Gitsigns setqflist<cr>", desc = "set quickfix list" },
					{ "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, desc = "stage selection", mode = "v" },
					{ "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, desc = "reset selection", mode = "v" },
					{ "<leader>hS", gs.stage_buffer, desc = "stage buffer", icon = _icon },
					{ "<leader>hu", gs.undo_stage_hunk, desc = "stage buffer", icon = _icon },
					{ "<leader>hR", gs.reset_buffer, desc = "reset buffer", icon = _icon },
					{ "<leader>hp", gs.preview_hunk, desc = "preview hunk" },
					{ "<leader>hb", function() gs.blame_line({ full = true }) end, desc = "blame line" },
					{ "<leader>hd", gs.diffthis, desc = "diff index" },
					{ "<leader>hD", function() gs.diffthis("~") end, desc = "diff last commit ~" },


					{ "<leader>ht", group = "Toggle" },
					{ "<leader>htb", gs.toggle_current_line_blame, desc = "current line blame" },
					{ "<leader>htd", gs.toggle_deleted, desc = "deleted lines" },
				})
			end,
		})
	end,
}
