-- NOTE: blink's buffer source only indexes words starting with a letter or `_`
-- (regex `[\p{L}_][\p{L}0-9_\\-]{2,}`), so words like `123-asdf` are never
-- offered. This source fills that gap with words that start with a digit.

-- word chars: ascii alnum, `_`, `-` and utf-8 multibyte (accented letters)
local WORD = "[%w_%-\128-\255]+"
local MIN_LENGTH = 3
local MAX_BUFFER_SIZE = 200000

local source = {}

function source.new(opts)
	local self = setmetatable({}, { __index = source })
	self.opts = opts or {}
	self.cache = {} -- bufnr -> { tick, words }
	return self
end

local function get_bufnrs()
	local bufnrs, seen = {}, {}
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if not seen[buf] and vim.bo[buf].buftype ~= "nofile" then
			seen[buf] = true
			table.insert(bufnrs, buf)
		end
	end
	return bufnrs
end

local function extract_words(lines)
	local text = table.concat(lines, "\n")
	if #text > MAX_BUFFER_SIZE then
		return {}
	end

	local words = {}
	for word in text:gmatch(WORD) do
		if #word >= MIN_LENGTH and word:match("^%d") then
			words[word] = true
		end
	end
	return words
end

function source:get_buf_words(bufnr)
	local tick = vim.api.nvim_buf_get_changedtick(bufnr)
	local cached = self.cache[bufnr]
	if cached and cached.tick == tick then
		return cached.words
	end

	local words = extract_words(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false))
	self.cache[bufnr] = { tick = tick, words = words }
	return words
end

function source:get_completions(context, callback)
	-- word being typed, so it doesn't complete to itself
	local line = context.line
	local col = context.cursor[2]
	local typed = line:sub(1, col):match(WORD .. "$") or ""
	typed = typed .. (line:sub(col + 1):match("^" .. WORD) or "")

	local unique, items = {}, {}
	local kind_text = require("blink.cmp.types").CompletionItemKind.Text
	for _, bufnr in ipairs(get_bufnrs()) do
		for word in pairs(self:get_buf_words(bufnr)) do
			if not unique[word] and word ~= typed then
				unique[word] = true
				table.insert(items, {
					label = word,
					kind = kind_text,
					insertTextFormat = vim.lsp.protocol.InsertTextFormat.PlainText,
					insertText = word,
				})
			end
		end
	end

	callback({ is_incomplete_forward = false, is_incomplete_backward = false, items = items })
end

return source
