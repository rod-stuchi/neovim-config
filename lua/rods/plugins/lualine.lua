return {
	"nvim-lualine/lualine.nvim",
	requires = { "nvim-tree/nvim-web-devicons", opt = true },
	config = function()
		local function diff_source()
			local gitsigns = vim.b.gitsigns_status_dict
			if gitsigns then
				return {
					added = gitsigns.added,
					modified = gitsigns.changed,
					removed = gitsigns.removed,
				}
			end
		end
		local function spell()
			if vim.wo.spell == true then -- Note that 'spell' is a window option, so: wo
				return "[" .. vim.bo.spelllang .. "]"
			end
			return ""
		end

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				-- component_separators = { left = "", right = "" },
				-- section_separators = { left = "", right = "" },
				-- component_separators = { left = "▎", right = "▎" },
				-- section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				-- lualine_b = { "branch", "diff", "diagnostics" },
				lualine_b = {
					{ "b:gitsigns_head", icon = "" },
					{ "diff", source = diff_source },
					{ "diagnostics", sources = { "nvim_diagnostic", "coc" } },
				},
				lualine_c = { "filename" },
				-- lualine_c = { custom_fname },
				lualine_x = { spell, "encoding", "fileformat", "filetype", "filesize" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {
				"fzf",
			},
		})
	end,
}
