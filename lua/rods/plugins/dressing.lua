return {
	"stevearc/dressing.nvim",
	opts = {},
	config = function()
		require("dressing").setup({
			input = {
				enabled = true,
				default_prompt = "Input",
				trim_prompt = true,
				title_pos = "left",
				insert_only = true,
				start_in_insert = true,
				border = "rounded",
				relative = "cursor",
				prefer_width = 40,
				width = nil,
				max_width = { 140, 0.9 },
				min_width = { 20, 0.2 },
				buf_options = {},
				win_options = {
					wrap = false,
					list = true,
					listchars = "precedes:…,extends:…",
					sidescrolloff = 0,
				},
				mappings = {
					n = {
						["<Esc>"] = "Close",
						["<CR>"] = "Confirm",
					},
					i = {
						["<C-c>"] = "Close",
						["<CR>"] = "Confirm",
						["<Up>"] = "HistoryPrev",
						["<Down>"] = "HistoryNext",
					},
				},
				override = function(conf)
					return conf
				end,
				get_config = nil,
			},
			select = {
				enabled = true,
				backend = { "fzf", "telescope", "fzf_lua", "builtin", "nui" },
				trim_prompt = true,
				fzf = {
					window = {
						width = 0.5,
						height = 0.4,
					},
				},
				builtin = {
					show_numbers = true,
					border = "rounded",
					relative = "editor",
					buf_options = {},
					win_options = {
						cursorline = true,
						cursorlineopt = "both",
					},
					width = nil,
					max_width = { 140, 0.8 },
					min_width = { 40, 0.2 },
					height = nil,
					max_height = 0.9,
					min_height = { 10, 0.2 },
					mappings = {
						["<Esc>"] = "Close",
						["<C-c>"] = "Close",
						["<CR>"] = "Confirm",
					},
					override = function(conf)
						return conf
					end,
				},
				format_item_override = {},
				get_config = nil,
			},
		})
	end,
}
