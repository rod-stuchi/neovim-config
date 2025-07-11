return {
	"andrewferrier/debugprint.nvim",

	config = function()
		-- vim.api.nvim_set_hl(0, "DebugPrintLine", { fg = "#ff0000", bg = "#333333" })
		vim.api.nvim_set_hl(0, "DebugPrintLine", { bg = "#383222" })
		local counter = 0
		local gen_emoji = function()
			-- local emojis = { "💣", "🐭", "💩", "🫠", "🤡", "👻" }
			-- local rnd = math.random(1, #emojis)
			-- local emoji = emojis[rnd]

			local emoji = Get_emoji(false, 2)
			counter = counter + 1
			return "[" .. tostring(counter) .. " " .. emoji .. "]"
		end

		require("debugprint").setup({
			display_counter = gen_emoji,
		})
	end,
	opts = {
		keymaps = {
			normal = {
				plain_below = "g?p",
				plain_above = "g?P",
				variable_below = "g?v",
				variable_above = "g?V",
				variable_below_alwaysprompt = "",
				variable_above_alwaysprompt = "",
				surround_plain = "t?fc",
				fheebhaq_inevnoyr = "g?sv",
				surround_variable_alwaysprompt = "",
				textobj_below = "g?o",
				textobj_above = "g?O",
				textobj_surround = "g?so",
				toggle_comment_debug_prints = "",
				delete_debug_prints = "",
			},
			insert = {
				plain = "<C-G>p",
				variable = "<C-G>v",
			},
			visual = {
				variable_below = "g?v",
				variable_above = "g?V",
			},
		},
	},

	dependencies = {
		"echasnovski/mini.hipatterns", -- Optional: Needed for line highlighting ('fine-grained' hipatterns plugin)
		"folke/snacks.nvim", -- Optional: If you want to use the `:Debugprint search` command with snacks.nvim
	},

	lazy = false, -- Required to make line highlighting work before debugprint is first used
	version = "*", -- Remove if you DON'T want to use the stable version
}
