return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf_lua = require("fzf-lua")
		local Job = require("plenary.job")

		-- Define a function that adds the current file to the frecency database.
		function Update_frecency_db()
			-- Get the path to the file being opened
			local filepath = vim.fn.expand("%:p")

			-- If it's a valid file, not an unnamed [No Name] buffer or empty string
			if filepath ~= "" and filepath ~= nil then
				Job:new({
					command = "fre",
					args = { "--add", filepath },
					on_exit = function(j, return_val)
						if return_val == 0 then
							print("Fre: File added to frecency database.")
						else
							print("Fre: Error while adding file to frecency database.")
						end
					end,
					on_stderr = function(j, error_message)
						print("Fre: Error: " .. error_message)
					end,
				}):start()
			end
		end

		local function remove_git_status_icons(str)
			return str:sub(4):gsub("^[^a-zA-Z]*", "")
		end

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
					-- ["default"] = function(selecteds)
					-- 	for i, v in ipairs(selecteds) do
					-- 		local f = remove_git_status_icons(v)
					-- 		if i == 1 then
					-- 			vim.cmd("edit " .. f)
					-- 			update_frecency_db()
					-- 		else
					-- 			vim.fn.setqflist({ { filename = f } }, "a")
					-- 		end
					-- 	end
					-- 	if #selecteds > 1 then
					-- 		vim.cmd("copen")
					-- 	end
					-- end,
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
		vim.keymap.set({ "n", "v", "i" }, "<C-x><C-f>", function()
			fzf_lua.complete_file({
				cmd = "rg --files",
				complete = true,
				winopts = { preview = { hidden = "nohidden" } },
			})
		end, { silent = true, desc = "Fuzzy complete file" })

		-- ================================================================================
		-- complete relative path
		vim.keymap.set({ "n", "v", "i" }, "<C-x><C-r>", function()
			local current_dir = vim.fn.expand("%:p:h")
			fzf_lua.complete_file({
				cmd = "fd --type f | xargs realpath --relative-to " .. current_dir,
				complete = true,
			})
		end, { silent = true, desc = "Fuzzy complete relative file" })

		-- ================================================================================
		-- complete buffer line
		vim.keymap.set(
			{ "n", "v", "i" },
			"<C-x><C-l>",
			"<cmd>FzfLua complete_bline<cr>",
			{ silent = true, desc = "Fuzzy complete cur buffer lines" }
		)

		-- ================================================================================
		-- complete project line
		vim.keymap.set(
			{ "n", "v", "i" },
			"<C-x><C-k>",
			"<cmd>FzfLua complete_line<cr>",
			{ silent = true, desc = "Fuzzy complete open buffers lines" }
		)

		-- ================================================================================
		-- files frecency
		-- vim.api.nvim_create_user_command("FzfLuaFrecency", function()
		-- end, {})
		function FzfLuaFrecencyX()
			local cwd = vim.fn.getcwd()
			local job = require("plenary.job"):new({
				-- https://github.com/camdencheek/fre
				command = "fre",
				args = { "--sorted" },
				on_exit = function(j, return_code)
					if return_code ~= 0 then
						vim.notify("fre command failed", vim.log.levels.ERROR)
						return
					end
					local output = table.concat(j:result(), "\n")
					local lines = vim.split(output, "\n")
					vim.schedule(function()
						fzf_lua.fzf_exec(lines, {
							fn_transform = function(x)
								local relative_path = vim.fn.fnamemodify(x, ":.")
								return fzf_lua.make_entry.file(relative_path, { file_icons = true, color_icons = true })
							end,
							prompt = "Fre> ",
							actions = {
								["default"] = function(selected)
									vim.cmd("edit " .. selected[1])
								end,
							},
							fzf_opts = {
								["--no-sort"] = "",
								["--multi"] = true,
								["--tiebreak"] = "index",
								["--layout"] = "default",
							},
						})
					end)
				end,
			})
			job:start()
		end

		function FzfLuaFrecency()
			local cwd = vim.fn.getcwd()
			local job = require("plenary.job"):new({
				-- https://github.com/camdencheek/fre
				command = "fre",
				args = { "--sorted" },
				on_exit = function(fre_job, return_code)
					if return_code ~= 0 then
						vim.notify("fre command failed", vim.log.levels.ERROR)
						return
					end
					local output_fre = table.concat(fre_job:result(), "\n")
					Job:new({
						command = "rg",
						args = { cwd },
						writer = output_fre, -- feed the output of `fre` to `rg`
						on_exit = function(rg_job, _)
							local output_rg = table.concat(rg_job:result(), "\n")
							local lines = vim.split(output_rg, "\n")
							vim.schedule(function()
								fzf_lua.fzf_exec(lines, {
									prompt = "Fre> ",
									actions = {
										["default"] = function(selected)
											vim.cmd("edit " .. selected[1])
										end,
									},
									fzf_opts = {
										["--no-sort"] = "",
										["--multi"] = true,
										["--tiebreak"] = "index",
										["--layout"] = "default",
									},
									fn_transform = function(x)
										local relative_path = vim.fn.fnamemodify(x, ":.")
										return fzf_lua.make_entry.file(
											relative_path,
											{ file_icons = true, color_icons = true }
										)
									end,
								})
							end)
						end,
					}):start()
				end,
			})
			job:start()
		end

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
