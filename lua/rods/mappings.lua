-- vim: fdm=marker:foldlevel=1:
-- vim.api.nvim_commnad("command! TSRehighlight :write | edit | TSBufEnable hightlight")

local keymap = vim.keymap.set

keymap({ "n", "v" }, ";", ":")
keymap({ "n", "v" }, ":", ";")

keymap("n", "Q", "<nop>")

-- remap digraphs, conflict with cmp
keymap("i", "<c-y>", "<c-k>")

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

keymap("n", "<leader>sg", function()
	local word = vim.fn.expand("<cword>")
	vim.cmd("RG " .. word)
end, { desc = "RG word cursor" })

keymap("n", "<leader>sb", function()
	local word = vim.fn.expand("<cword>")
	vim.cmd("RGw " .. word)
end, { desc = "RG -w 'word' boundaries cursor" })

keymap("n", "<leader>fd", vim.cmd.FdOne, { desc = "fzf neighbor depth 1" })
keymap("n", "<leader>fe", vim.cmd.FdAll, { desc = "fzf neighbor" })

keymap("n", "gO", "<cmd>!mimeo <cfile> & disown<CR><CR>", { desc = "Open with external default program" })

keymap("n", "<BS>", "<cmd>b#<CR>", { desc = "back to alternate file" })

vim.cmd([[
   command W :execute ':silent w !sudo tee % > /dev/null' | :edit! 
]])

-- reload snippets
-- keymap('n', '<leader><leader>s', "<cmd>source ~/.config/nvim/lua/rods/plugins/luasnip.lua<cr>")

-- commands with preserve
-- disabled because when at the end of a word, yiw do not work
-- keymap('n', 'yip', [[ :lua preserve('normal! yip')<CR>2h ]], opts)
-- keymap('n', 'yiw', [[ :lua preserve('normal! yiw')<CR> ]])
-- keymap('n', '<space>==', [[ :lua preserve('normal! gg=G')<CR>2h ]], opts)
