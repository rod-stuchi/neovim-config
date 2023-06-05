local M = {}

function M.setCustomHighLights()
	vim.cmd([[ 
  " line column colors
  highlight LineNrAbove guibg=#1e2127 guifg=#414855
  highlight LineNr guifg=#a8a250
  highlight LineNrBelow guibg=#1e2127 guifg=#414855
  " git
  highlight SignColumn  guibg=#1e2127
  highlight GitSignsAdd  guibg=#1e2127
  highlight GitSignsChange  guibg=#1e2127
  highlight GitSignsDelete  guibg=#1e2127
  " lsp
  highlight DiagnosticInfo guibg=#1e2127
  highlight DiagnosticError guibg=#1e2127
  highlight DiagnosticWarn guibg=#1e2127
  highlight DiagnosticHint guibg=#1e2127
  ]])

	-- vim.cmd([[au VimEnter * highlight Folded guifg=#465a7d]])
	-- vim.cmd([[au ColorScheme * highlight Folded guifg=#465a7d]])
	-- vim.cmd([[au VimEnter * highlight IncSearch guifg=#ab7f54 guibg=#00000000 ]])
	-- vim.cmd([[au ColorScheme * highlight IncSearch guifg=#ab7f54 guibg=#00000000 ]])
end

function M.toggle_transparency()
	local theme = vim.g.colors_name
	local hasBackground = vim.api.nvim_get_hl_by_name("Normal", true)["background"]
	require(theme).setup({
		unpack(require(theme).config),
		transparent = (hasBackground ~= nil),
		dimInactive = (hasBackground == nil),
	})

	vim.cmd("colorscheme " .. theme)
	M.setCustomHighLights()
end
--
-- ref:
-- https://dev.to/voyeg3r/my-ever-growing-neovim-init-lua-h0p
-- https://dev.to/voyeg3r/writing-useful-lua-functions-to-my-neovim-14ki
M.preserve = function(arguments)
	local args = string.format("keepjumps keeppatterns execute %q", arguments)
	-- local original_cursor = vim.fn.winsaveview()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	vim.api.nvim_command(args)
	local lastline = vim.fn.line("$")
	-- vim.fn.winrestview(original_cursor)
	if line > lastline then
		line = lastline
	end
	vim.api.nvim_win_set_cursor(0, { line, col })
end
_G.preserve = M.preserve

M.squeeze_blank_lines = function()
	-- references: https://vi.stackexchange.com/posts/26304/revisions
	if vim.bo.binary == false and vim.opt.filetype:get() ~= "diff" then
		local old_query = vim.fn.getreg("/") -- save search register
		M.preserve("sil! 1,.s/^\\n\\{2,}/\\r/gn") -- set current search count number
		local result = vim.fn.searchcount({ maxcount = 1000, timeout = 500 }).current
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		M.preserve("sil! keepp keepj %s/^\\n\\{2,}/\\r/ge")
		M.preserve("sil! keepp keepj %s/^\\s\\+$/\\r/ge")
		M.preserve("sil! keepp keepj %s/\\v($\\n\\s*)+%$/\\r/e")
		if result > 0 then
			vim.api.nvim_win_set_cursor(0, { (line - result), col })
		end
		vim.fn.setreg("/", old_query) -- restore search register
	end
end

vim.api.nvim_create_user_command("RodRemoveTrailingSpaces", function()
	M.preserve("%s/\\s\\+$//ge")
end, {})

vim.api.nvim_create_user_command("RodRemoveHardSpaces", function()
	M.preserve("%s/\\%xa0/ /g")
end, {})

-- https://www.reddit.com/r/neovim/comments/zhweuc/comment/izo9br1/?utm_source=share&utm_medium=web2x&context=3
vim.api.nvim_create_user_command('Redir', function(ctx)
  local lines = vim.split(vim.api.nvim_exec(ctx.args, true), '\n', { plain = true })
  vim.cmd('new')
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.opt_local.modified = false
end, { nargs = '+', complete = 'command' })

vim.cmd("source" .. vim.fn.stdpath("config") .. "/lua/rods/vim-funcs/center_cursor.vim")
vim.cmd("source" .. vim.fn.stdpath("config") .. "/lua/rods/vim-funcs/fold_comments.vim")
vim.cmd("source" .. vim.fn.stdpath("config") .. "/lua/rods/vim-funcs/remove_diacritics.vim")

return M
