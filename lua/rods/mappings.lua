-- vim: fdm=marker:foldlevel=1:
-- vim.api.nvim_commnad("command! TSRehighlight :write | edit | TSBufEnable hightlight")

local keymap = vim.keymap.set

keymap({ "n", "v" }, ";", ":")
keymap({ "n", "v" }, ":", ";")

keymap("n", "Q", "<nop>")

-- remap digraphs, conflict with cmp
-- keymap("i", "<c-y>", "<c-k>")

keymap("n", "\\", "<cmd>noh<cr>")
keymap("n", "<M-o>", "<cmd>copen<cr>")
keymap("n", "<M-O>", "<cmd>cclose<cr>")
keymap("n", "<M-[>", "<cmd>cprevious<cr>")
keymap("n", "<M-]>", "<cmd>cnext<cr>")

-- make search result appear in the middle
keymap("n", "n", "nzz")
keymap("n", "N", "Nzz")
keymap("n", "*", "*zz")
keymap("n", "#", "#zz")
keymap("n", "g*", "g*zz")
keymap("n", "g#", "g#zz")

keymap("n", "<M-t>", "<c-w>+") -- resize split
keymap("n", "<M-s>", "<c-w>-") -- resize split
keymap("n", "<M-h>", "<c-w>5<") -- resize split
keymap("n", "<M-l>", "<c-w>5>") -- resize split

keymap("c", "%%", [[getcmdtype() == ':' ? expand('%:h').'/' : '%%' ]], { noremap = true, expr = true })
keymap("c", ":mk", "mksession! _S<cr>", { silent = false, desc = "Make a session '_S'" })

-- from: https://www.reddit.com/r/neovim/comments/16mijcz/comment/k18jbee/?utm_source=share&utm_medium=web2x&context=3
vim.cmd("inoreabbrev <expr> _uuid system('uuidgen')->trim()->tolower()")
vim.cmd("inoreabbrev <expr> _cpf system('cpf')->trim()")
vim.cmd("inoreabbrev <expr> _cpff system('cpf -m')->trim()")
vim.cmd("inoreabbrev <expr> _oid system('oid')->trim()")
vim.cmd("iabbrev <expr> _d strftime('%Y-%m-%d')")
vim.cmd("iabbrev <expr> _t strftime('%Y-%m-%dT%TZ')")
vim.cmd("iabbrev <expr> _pwg system('pwgen --numerals --ambiguous --capitalize --secure 1 40')->trim()")
vim.cmd("iabbrev <expr> _pwgg system('pwgen --numerals --symbols --ambiguous --capitalize --secure 1 40')->trim()")
vim.cmd("iabbrev <expr> _pwd expand('%')")

-- moving lines
keymap("n", "<A-j>", ":m .+1<CR>==")
keymap("n", "<A-k>", ":m .-2<CR>==")
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- keymap("n", "<leader>sg", function()
-- 	local word = vim.fn.expand("<cword>")
-- 	vim.cmd("RG " .. word)
-- end, { desc = "RG word cursor" })

-- keymap("n", "<leader>sb", function()
-- 	local word = vim.fn.expand("<cword>")
-- 	vim.cmd("RGw " .. word)
-- end, { desc = "RG -w 'word' boundaries cursor" })

-- keymap("n", "<leader>fd", vim.cmd.FdOne, { desc = "fzf neighbor depth 1" })
-- keymap("n", "<leader>fe", vim.cmd.FdAll, { desc = "fzf neighbor" })

-- Use the appropriate command based on OS
if vim.fn.has("mac") == 1 then
	vim.keymap.set("n", "gO", "<cmd>!open <cfile><CR><CR>", { desc = "Open with external default program (macOS)" })
else
	vim.keymap.set("n", "gO", "<cmd>!mimeo <cfile> & disown<CR><CR>", { desc = "Open with external default program" })
end

keymap("n", "<BS>", "<cmd>b#<CR>", { desc = "back to alternate file" })

vim.cmd([[
   command W :execute ':silent w !sudo tee % > /dev/null' | :edit! 
]])

local function get_directories()
	local directories = {}

	local handle = io.popen("fd . --type directory")
	if handle then
		for line in handle:lines() do
			table.insert(directories, line)
		end
		handle:close()
	else
		print("Failed to execute fd command")
	end

	return directories
end

vim.keymap.set("n", "<leader>f1", function()
	local Snacks = require("snacks")
	local dirs = get_directories()

	return Snacks.picker({
		finder = function()
			local items = {}
			for i, item in ipairs(dirs) do
				table.insert(items, {
					idx = i,
					file = item,
					text = item,
				})
			end
			return items
		end,
		layout = {
			layout = {
				box = "horizontal",
				width = 0.5,
				height = 0.5,
				{
					box = "vertical",
					border = "rounded",
					title = "Find directory",
					{ win = "input", height = 1, border = "bottom" },
					{ win = "list", border = "none" },
				},
			},
		},
		format = function(item, _)
			local file = item.file
			local ret = {}
			local a = Snacks.picker.util.align
			local icon, icon_hl = Snacks.util.icon(file.ft, "directory")
			ret[#ret + 1] = { a(icon, 3), icon_hl }
			ret[#ret + 1] = { " " }
			ret[#ret + 1] = { a(file, 20) }

			return ret
		end,
		confirm = function(picker, item)
			picker:close()
			Snacks.picker.pick("files", {
				dirs = { item.file },
			})
		end,
	})
end)

local function get_variable_under_cursor()
	local current_line = vim.api.nvim_get_current_line()
	local cursor_col = vim.api.nvim_win_get_cursor(0)[2]

	local word_start, word_end

	word_start = cursor_col
	while word_start > 0 and current_line:sub(word_start, word_start):match("[%w_]") do
		word_start = word_start - 1
	end
	word_start = word_start + 1

	word_end = cursor_col + 1
	while word_end <= #current_line and current_line:sub(word_end, word_end):match("[%w_]") do
		word_end = word_end + 1
	end
	word_end = word_end - 1

	local var_name = current_line:sub(word_start, word_end)
	return var_name
end

-- Function to insert debug console.log for the variable under cursor
local function insert_debug_log()
	local var_name = get_variable_under_cursor()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local line = cursor_pos[1] - 1 -- 0-indexed for nvim_buf_set_lines
	local current_line_text = vim.api.nvim_buf_get_lines(0, line, line + 1, false)[1] or ""
	local indent = current_line_text:match("^%s*") or ""
	local file_type = vim.bo.filetype
	local emoji = Get_emoji(var_name == "")
	local debug_line = ""

	-- Create the debug line based on file type
	if var_name and var_name ~= "" then
		if
			file_type == "javascript"
			or file_type == "typescript"
			or file_type == "javascriptreact"
			or file_type == "typescriptreact"
		then
			debug_line = indent .. 'console.log("' .. emoji .. " DEBUG:: [" .. var_name .. ']", ' .. var_name .. ");"
		elseif file_type == "go" then
			debug_line = indent
				.. 'fmt.Printf("'
				.. emoji
				.. " DEBUG:: ["
				.. var_name
				.. ']: %+v\\n", '
				.. var_name
				.. ")"
		elseif file_type == "python" then
			debug_line = indent .. 'print(f"' .. emoji .. " DEBUG:: [" .. var_name .. "]: {" .. var_name .. '}")'
		elseif file_type == "rust" then
			debug_line = indent .. 'println!("' .. emoji .. " DEBUG:: [" .. var_name .. ']: {:?}", ' .. var_name .. ");"
		elseif file_type == "ruby" then
			debug_line = indent .. 'puts "' .. emoji .. " DEBUG:: [" .. var_name .. "]: #{" .. var_name .. '}"'
		else
			-- Default to JavaScript-like syntax for other languages
			debug_line = indent .. 'console.log("' .. emoji .. " DEBUG:: [" .. var_name .. ']", ' .. var_name .. ");"
		end
	else
		-- Empty debug statements without variable
		if
			file_type == "javascript"
			or file_type == "typescript"
			or file_type == "javascriptreact"
			or file_type == "typescriptreact"
		then
			debug_line = indent .. 'console.log("' .. emoji .. ' DEBUG::");'
		elseif file_type == "go" then
			debug_line = indent .. 'fmt.Println("' .. emoji .. ' DEBUG::")'
		elseif file_type == "python" then
			debug_line = indent .. 'print("' .. emoji .. ' DEBUG::")'
		elseif file_type == "rust" then
			debug_line = indent .. 'println!("' .. emoji .. ' DEBUG::"));'
		elseif file_type == "ruby" then
			debug_line = indent .. 'puts "' .. emoji .. ' DEBUG::"'
		else
			debug_line = indent .. 'console.log("' .. emoji .. ' DEBUG::");'
		end
	end

	vim.api.nvim_buf_set_lines(0, line + 1, line + 1, false, { debug_line })
end

vim.keymap.set("n", "<leader>dl", function()
	insert_debug_log()
end, { silent = true, desc = "Insert debug log for word under cursor" })

vim.keymap.set("i", "<C-d>", function()
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	insert_debug_log()
	vim.api.nvim_win_set_cursor(0, cursor_pos)
end, { silent = true, desc = "Insert debug log in insert mode" })

-- commands with preserve
-- disabled because when at the end of a word, yiw do not work
-- keymap('n', 'yip', [[ :lua preserve('normal! yip')<CR>2h ]], opts)
-- keymap('n', 'yiw', [[ :lua preserve('normal! yiw')<CR> ]])
-- keymap('n', '<space>==', [[ :lua preserve('normal! gg=G')<CR>2h ]], opts)
