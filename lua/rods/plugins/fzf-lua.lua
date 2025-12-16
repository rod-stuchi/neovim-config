return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf_lua = require("fzf-lua")
		local Job = require("plenary.job")

		-- ================================================================================
		-- setup
		fzf_lua.setup({
			buffers = {
				winopts = {
					row = 1,
					col = 0,
					width = 1,
					height = 0.4,
					title_pos = "left",
					border = { "", "─", "", "", "", "", "", "" },
					preview = {
						layout = "horizontal",
						title_pos = "right",
						border = function(_, m)
							if m.type == "fzf" then
								return "single"
							else
								assert(m.type == "nvim" and m.name == "prev" and type(m.layout) == "string")
								local b = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
								if m.layout == "down" then
									b[1] = "├" --top right
									b[3] = "┤" -- top left
								elseif m.layout == "up" then
									b[7] = "├" -- bottom left
									b[6] = "" -- remove bottom
									b[5] = "┤" -- bottom right
								elseif m.layout == "left" then
									b[3] = "┬" -- top right
									b[5] = "┴" -- bottom right
									b[6] = "" -- remove bottom
								else -- right
									b[1] = "┬" -- top left
									b[7] = "┴" -- bottom left
									b[6] = "" -- remove bottom
								end
								return b
							end
						end,
					},
				},
			},
			winopts = {
				preview = {
					default = "bat",
				},
			},
			actions = {
				files = {
					true,
					["default"] = fzf_lua.actions.file_edit,
				},
			},
			keymap = {
				fzf = {
					false, -- do not inherit from defaults
					-- fzf '--bind=' options
					["ctrl-z"] = "abort",
					["ctrl-u"] = "unix-line-discard",
					["ctrl-f"] = "half-page-down",
					["ctrl-b"] = "half-page-up",
					["ctrl-a"] = "beginning-of-line",
					["ctrl-e"] = "end-of-line",
					["alt-a"] = "toggle-all",
					["alt-g"] = "last",
					["alt-G"] = "first",
					-- Only valid with fzf previewers (bat/cat/git/etc)
					["f3"] = "toggle-preview-wrap",
					["f4"] = "toggle-preview",
					["ctrl-p"] = "toggle-preview",
					["ctrl-l"] = "select+down",
					["ctrl-h"] = "deselect+up",
					["alt-d"] = "preview-half-page-down",
					["alt-u"] = "preview-half-page-up",
					["alt-n"] = "preview-page-down",
					["alt-p"] = "preview-page-up",
					["alt-j"] = "preview-down",
					["alt-k"] = "preview-up",
				},
			},
		})

		-- ================================================================================
		-- complete hidden
		vim.keymap.set({ "i", "n" }, "<C-x><C-f>", function()
			fzf_lua.complete_path({
				cmd = "fd",
				winopts = { preview = { hidden = true } },
			})
		end, { silent = true, desc = "Fuzzy complete file" })

		-- ================================================================================
		-- complete relative path
		vim.keymap.set({ "i", "n" }, "<C-x><C-r>", function()
			local current_dir = vim.fn.expand("%:p:h")
			local realpath_cmd = vim.fn.has("mac") == 1 and "grealpath" or "realpath"
			fzf_lua.complete_file({
				cmd = "fd --type f | xargs " .. realpath_cmd .. " --relative-to " .. current_dir,
				complete = true,
			})
		end, { silent = true, desc = "Fuzzy complete relative file" })

		-- ================================================================================
		-- complete buffer line
		-- vim.keymap.set(
		-- 	{ "n", "v", "i" },
		-- 	"<C-x><C-l>",
		-- 	"<cmd>FzfLua complete_bline<cr>",
		-- 	{ silent = true, desc = "Fuzzy complete cur buffer lines" }
		-- )

		-- ================================================================================
		-- complete project line
		vim.keymap.set(
			{ "n", "v", "i" },
			"<C-x><C-k>",
			"<cmd>FzfLua complete_line<cr>",
			{ silent = true, desc = "Fuzzy complete open buffers lines" }
		)

		-- ================================================================================
		-- files max depth 1
		-- vim.api.nvim_create_user_command("FzfLuaDepth1", function()
		-- end, {})
		function FzfLuaDepth1()
			local current_dir = vim.fn.expand("%:p:h")
			fzf_lua.fzf_exec("fd . " .. current_dir .. " -tf --max-depth=1 --color=never", {
				actions = {
					["default"] = fzf_lua.actions.file_edit,
				},
				fn_transform = function(x)
					return fzf_lua.make_entry.file(x, { file_icons = true, color_icons = true })
				end,
			})
		end

		-- ================================================================================
		-- files from here
		-- vim.api.nvim_create_user_command("FzfLuaFromHere", function()
		-- end, {})
		function FzfLuaDepthN()
			local current_dir = vim.fn.expand("%:p:h")
			fzf_lua.fzf_exec("fd . " .. current_dir .. " -tf --color=never", {
				actions = {
					["default"] = fzf_lua.actions.file_edit,
				},
				fn_transform = function(x)
					return fzf_lua.make_entry.file(x, { file_icons = true, color_icons = true })
				end,
			})
		end
	end,
}
