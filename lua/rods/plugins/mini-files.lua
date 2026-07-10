return {
	"echasnovski/mini.files",
	version = false,
	config = function()
		local mini_files = require("mini.files")
		mini_files.setup({
			options = {
				-- Use mini.files as the default file explorer instead of netrw
				use_as_default_explorer = true,
			},
			windows = {
				-- Built-in preview shows BOTH files and directories; we want
				-- directories only, so it's handled manually below (see the
				-- CursorMoved autocmd). Keep it off here.
				preview = false,
				-- Current column wide; other columns (incl. our dir preview) readable.
				width_focus = 40,
				width_nofocus = 25,
			},
		})

		-- State to hold context for path completion
		local complete_state = nil

		-- Directory-only "preview on hover": expand the directory under the
		-- cursor in a column to the right (keeping focus), and collapse it when
		-- the cursor is on a file. `previewing` guards against re-entrancy since
		-- go_in/go_out/trim_right can move the cursor and re-fire CursorMoved.
		local previewing = false
		local function preview_dir_only()
			if previewing then
				return
			end
			local entry = mini_files.get_fs_entry()
			if not entry then
				return
			end
			previewing = true
			if entry.fs_type == "directory" then
				mini_files.go_in()
				mini_files.go_out()
			else
				mini_files.trim_right()
			end
			previewing = false
		end

		-- Keymap to trigger mini.files for relative path completion
		vim.keymap.set({ "i", "n" }, "<C-x><C-m>", function()
			local buf = vim.api.nvim_get_current_buf()
			local win = vim.api.nvim_get_current_win()
			local cursor = vim.api.nvim_win_get_cursor(win)
			local current_file = vim.api.nvim_buf_get_name(buf)
			if current_file == "" then
				current_file = vim.fn.getcwd()
			end
			local dir = vim.fn.expand("%:p:h")
			local is_insert = vim.fn.mode() == "i"

			complete_state = {
				buf = buf,
				win = win,
				cursor = cursor,
				dir = dir,
				is_insert = is_insert,
			}

			if is_insert then
				vim.cmd("stopinsert")
			end

			mini_files.open(current_file)
		end, { silent = true, desc = "Mini.files complete relative file" })

		-- Clear state when mini.files is closed to prevent accidental overriding of <CR> later
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesExplorerClose",
			callback = function()
				complete_state = nil
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			callback = function(args)
				local buf_id = args.data.buf_id

				-- Preview directories (only) as the cursor moves over them
				vim.api.nvim_create_autocmd("CursorMoved", {
					buffer = buf_id,
					callback = preview_dir_only,
				})

				-- Go in / complete path (bound to `l` below)
				local go_in_plus = function()
					local entry = mini_files.get_fs_entry(buf_id)
					if complete_state and entry and entry.fs_type == "file" then
						local state = complete_state
						complete_state = nil -- Clear state to prevent multiple completions

						mini_files.close()

						vim.schedule(function()
							local realpath_cmd = vim.fn.has("mac") == 1 and "grealpath" or "realpath"
							local rel_path = vim.fn.system(
								realpath_cmd
									.. " --relative-to "
									.. vim.fn.shellescape(state.dir)
									.. " "
									.. vim.fn.shellescape(entry.path)
							):gsub("\n", "")

							-- Insert the path
							local line = state.cursor[1] - 1
							local col = state.cursor[2]

							if vim.api.nvim_buf_is_valid(state.buf) then
								vim.api.nvim_buf_set_text(state.buf, line, col, line, col, { rel_path })
							end

							if vim.api.nvim_win_is_valid(state.win) then
								vim.api.nvim_set_current_win(state.win)
								if vim.api.nvim_buf_is_valid(state.buf) then
									vim.api.nvim_win_set_buf(state.win, state.buf)
								end
								vim.api.nvim_win_set_cursor(state.win, { state.cursor[1], state.cursor[2] + #rel_path })
								if state.is_insert then
									vim.cmd("startinsert")
								end
							end
						end)
					else
						-- Default behavior: go in (directories are previewed on hover via
						-- the CursorMoved autocmd, so <CR> just navigates in/opens files)
						mini_files.go_in({ close_on_file = true })
					end
				end

				-- Use `l` (hjkl-natural) to go in / choose the file
				vim.keymap.set("n", "l", go_in_plus, { buffer = buf_id, desc = "Go in or complete path" })
				-- <CR> does nothing
				vim.keymap.set("n", "<CR>", "<Nop>", { buffer = buf_id, desc = "Disabled" })
				-- <Esc> closes the explorer (like `q`)
				vim.keymap.set("n", "<Esc>", mini_files.close, { buffer = buf_id, desc = "Close" })
			end,
		})
	end,
}
