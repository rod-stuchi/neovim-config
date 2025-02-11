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

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "swhkdrc",
	callback = function()
		vim.fn.system("pkill -HUP swhkd")
		vim.fn.system('dunstify -t 700 -u low "swhkd reloaded"')
	end,
	group = "sxhkdrcAutoCmd",
})

vim.cmd("packadd cfilter")

vim.api.nvim_create_augroup("au_custom_rods", {})
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePre" }, {
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		vim.opt.endoffile = true
		vim.opt.endofline = true
		vim.opt.fixendofline = true

		-- ref.: https://www.reddit.com/r/neovim/comments/10mqhs3/comment/j6atyxu
		-- local get_filename = function(path)
		-- 	local filename_with_relative_path = vim.fn.substitute(path, vim.fn.getcwd() .. "/", "", "")
		-- 	return filename_with_relative_path
		-- end

		-- vim.opt_local.winbar = "%=%m " .. get_filename(vim.fn.expand("%"))
	end,
	group = "au_custom_rods",
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	group = vim.api.nvim_create_augroup("float_diagnostic_cursor", { clear = true }),
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("au_format_rods", { clear = true }),
	pattern = {
		"*.css",
		"*.go",
		"*.js",
		"*.lua",
		"*.prisma",
		"*.py",
		"*.rs",
		"*.scss",
		"*.ts",
	},
	callback = function()
		vim.cmd("write")
		vim.lsp.buf.format({ async = false })
		vim.cmd("edit")
	end,
})
