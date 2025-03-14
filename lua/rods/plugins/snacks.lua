return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		explorer = { enabled = true },
		indent = { enabled = true },
		picker = {
			enabled = true,
			win = {
				input = {
					keys = {
						["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
						["<C-h>"] = { "select_and_prev", mode = { "i", "n" } },
						["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
						["<C-l>"] = { "select_and_next", mode = { "i", "n" } },
					},
				},
				list = {
					keys = {
						["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
						["<C-h>"] = { "select_and_prev", mode = { "i", "n" } },
						["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
						["<C-l>"] = { "select_and_next", mode = { "i", "n" } },
					},
				},
			},
		},
		notifier = { enabled = true },
	},
	keys = {
		-- {
		-- 	"<leader>bD",
		-- 	function()
		-- 		Snacks.bufdelete()
		-- 	end,
		-- 	desc = "Delete Buffer",
		-- },
		{
			"<leader>pR",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<leader>\\",
			function()
				Snacks.picker()
			end,
		},
		{
			"<leader>,",
			function()
				Snacks.picker.buffers({
					focus = "list",
					layout = { preset = "ivy", layout = { position = "bottom" } },
					current = true,
					sort_lastused = true,
				})
			end,
			desc = "Buffers",
		},
		--[[ {
			"<leader>x",
			function()
				return require("snacks.picker.source.proc").proc({
					cmd = "eza",
					args = { "-l", "." },
					transform = function(item)
						-- You can transform the item here if needed
						return item
					end,
					layout = { preset = "ivy", layout = { position = "bottom" } },
					on_select = function(item)
						-- Get the current cursor position
						local row, col = unpack(vim.api.nvim_win_get_cursor(0))
						-- Insert the selected item at the current cursor position
						vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { item })
						-- Return true to close the picker after selection
						return true
					end,
				})
			end,
			desc = "Insert file listing at cursor",
		}, ]]
	},
}
