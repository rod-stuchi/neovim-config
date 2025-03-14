local opt = vim.opt -- set option
local g = vim.g -- set global
-- ###### DEFAULTS ######
-- opt.belloff = "all"
-- opt.hidden = true
-- opt.history = 10000
-- opt.hlsearch = true
-- opt.showcmd = true
-- vim.cmd("syntax on")
--
-- ### DISABLED ###
-- opt.fileencoding = 'utf-8' -- bug with lazy during install (nvim opening)
-- opt.undodir = vim.fn.stdpath("cache") .. "/undo"
-- opt.undofile = true
-- vim.cmd [[ set fileencoding='utf-8' ]]

g["python3_host_prog"] = "/home/rods/.pyenv/shims/python"

opt.backup = false
opt.cmdheight = 1
opt.encoding = "utf-8"
opt.expandtab = true
opt.fillchars:append("fold:•")
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 4
opt.foldmethod = "expr"
opt.foldopen:remove({ "search" })
opt.formatoptions:remove({ "o", "c" })
opt.guifont = "Fira Code 10"
opt.ignorecase = true
opt.inccommand = "split"
opt.laststatus = 3
opt.linespace = 4
opt.list = true
opt.listchars = { tab = "›∙", trail = "∙", eol = "↲", nbsp = "␣" }
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.scrolloff = 8
opt.shiftwidth = 4
opt.shortmess:append("c")
opt.showbreak = "↪"
opt.showmode = true
opt.sidescrolloff = 8
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 4
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 4
opt.termguicolors = true
opt.title = true
opt.updatetime = 500
opt.wildignore = "*/tmp/*,*.so,*.swp,*.zip,node_modules,.git"
opt.wrap = false
-- https://twitter.com/vim_tricks/status/1714387192284426539
opt.shiftround = true
-- https://github.com/neovim/neovim/pull/9496#issuecomment-1909973603
opt.breakindent = true

-- to add a '\n' at the end of line in the end of the file
opt.fixendofline = true
opt.endofline = true

-- opt.winbar = "%=%m %f"

-- to load local vim/nvim configuration
opt.exrc = true

-- https://kulala.mwco.app/docs/requirements#optional-requirements
vim.filetype.add({
	extension = {
		["http"] = "http",
	},
})

-- to detect golang (hugo) templates
-- https://neovim.io/doc/user/lua.html#vim.filetype.add()
-- needs to TSinstall gotmpl
vim.filetype.add({
	extension = {
		["html"] = function()
			if vim.fn.search("{{") ~= 0 then
				return "gotmpl"
			end
			return "html"
		end,
	},
})
