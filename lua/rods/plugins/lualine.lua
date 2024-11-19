return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
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
		local function inlay_hint()
			if vim.lsp.inlay_hint.is_enabled() then
				return "inlay: 👀"
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
					statusline = 250,
					tabline = 250,
					winbar = 250,
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
				lualine_c = { "filename", inlay_hint },
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
			tabline = {
				lualine_a = { { "buffers", mode = 0, filetype_names = { ["snipe-menu"] = " " } } },
				-- lualine_b = {},
				-- lualine_c = {},
				-- lualine_x = {},
				-- lualine_y = {},
				lualine_z = { "tabs" },
			},
			winbar = {},
			inactive_winbar = {},
			extensions = {
				"fzf",
			},
		})
	end,
}
