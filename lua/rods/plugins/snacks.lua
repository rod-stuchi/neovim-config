if _G.snacks_indent_enabled == nil then
	_G.snacks_indent_enabled = true
end
_G.toggle_snacks_indent = function()
	if _G.snacks_indent_enabled then
		require("snacks").indent.disable()
		vim.notify("Snacks indent disabled")
	else
		require("snacks").indent.enable()
		vim.notify("Snacks indent enabled")
	end
	_G.snacks_indent_enabled = not _G.snacks_indent_enabled
end

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
		-- stylua: ignore start
		{ "<leader>bd", function() Snacks.bufdelete({ wipe = true }) end,   desc = "delete Buffer" },
		{ "<leader>fe", function() Snacks.picker.grep() end,                desc = "Grep" },
		{ "<leader>ff", function() Snacks.picker.files() end,               desc = "Files" },
		{ "<leader>fg", function() Snacks.picker.git_files() end,           desc = "Git files" },
		{ "<leader>fr", function() Snacks.picker.resume() end,              desc = "Resume" },
		{ "<leader>ft", function() Snacks.picker.git_status() end,          desc = "Git files status" },
		{ "<leader>fw", function() Snacks.picker.grep_word() end,           desc = "Grep word" },
		{ "<leader>nh", function() Snacks.notifier.show_history() end,      desc = "Notifier show history" },
		{ "<leader>nx", function() Snacks.notifier.hide() end,              desc = "Notifier hide all" },
		{ "<leader>\\", function() Snacks.picker() end,                     desc = "Snacks Picker" },

		{ "<leader>.",  function() Snacks.scratch({ ft = "markdown" }) end, desc = "Toggle Scratch Buffer" },
		{ "<leader>S",  function() Snacks.scratch.select() end,             desc = "Select Scratch Buffer" },
		-- stylua: ignore end
		{
			"<leader>,",
			function()
				Snacks.picker.buffers({
					focus = "list",
					-- layout = { preset = "ivy", layout = { position = "bottom" } },
					current = true,
					sort_lastused = true,
				})
			end,
			desc = "Buffers",
		},
	},
}
