---@diagnostic disable: undefined-global
vim.cmd([[
    "autocmd! BufWinLeave * let b:winview = winsaveview()
    "autocmd! BufWinEnter * if exists('b:winview') | call winrestview(b:winview) | unlet b:winview
    "autocmd FileType css,javascript,json,scss,yml,yaml setl iskeyword+=-
    "autocmd FileType git set nofoldenable

    augroup rods_highlights
      autocmd!
      highlight breakSpace ctermfg=46 guifg=#00ff00
      " match does not work if has more than one
      " match breakSpace /\%xa0/
      call matchadd('breakSpace', '\%xa0')

      "highlight ColorColumn88 ctermbg=magenta guibg=#b41158
      "call matchadd('ColorColumn88', '\%88v')
    augroup END

]])

vim.api.nvim_create_augroup("FileTypeAdjustments", {})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "css,javascript,json,scss,yml,yaml",
	callback = function()
		--set iskeyword+=-
		vim.opt.iskeyword:append({ "-" })
	end,
	group = "FileTypeAdjustments",
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua", -- or { 'lua', 'help' },
	callback = function()
		vim.treesitter.start()
	end,
	group = "FileTypeAdjustments",
})

vim.api.nvim_create_augroup("Git", {})
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "COMMIT_EDITMSG",
	callback = function()
		vim.cmd("set spell spelllang=en_us")
		-- insert mode if line empty
		vim.api.nvim_win_set_cursor(0, { 1, 0 })
		if vim.fn.getline(1) == "" then
			vim.cmd("startinsert!")
		end
	end,
	group = "Git",
})
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "COMMIT_EDITMSG",
	callback = function()
		vim.opt.foldenable = false
	end,
	group = "Git",
})

vim.api.nvim_create_augroup("highlight_yank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 400 })
	end,
	group = "highlight_yank",
})

vim.api.nvim_create_augroup("sxhkdrcAutoCmd", {})
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "sxhkdrc",
	callback = function()
		vim.fn.system("pkill -10 sxhkd")
		vim.fn.system('dunstify -t 700 -u low "sxhkd reloaded"')
	end,
	group = "sxhkdrcAutoCmd",
})

vim.cmd("packadd cfilter")

