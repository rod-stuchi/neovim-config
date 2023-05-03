-- vim: fdm=marker:foldlevel=1:
-- vim.api.nvim_commnad("command! TSRehighlight :write | edit | TSBufEnable hightlight")

local keymap = vim.keymap.set

keymap({ "n", "v" }, ";", ":")
keymap({ "n", "v" }, ":", ";")

keymap("n", "Q", "<nop>")

keymap("n", "<BS>", "<cmd>noh<cr>")
keymap("n", "<M-o>", "<cmd>copen<cr>")
keymap("n", "<M-O>", "<cmd>cclose<cr>")
keymap("n", "<M-[>", "<cmd>cprevious<cr>")
keymap("n", "<M-]>", "<cmd>cnext<cr>")

keymap("c", "%%", [[getcmdtype() == ':' ? expand('%:h').'/' : '%%' ]], { noremap = true, expr = true })

keymap("i", "UU", "<c-r>=system(\"uuidgen -r | tr -d '\\n'\")<cr>")
keymap("i", "CPF", "<c-r>=system(\"cpf | tr -d '\\n'\")<cr>")
keymap("i", "CPFF", "<c-r>=system(\"cpf -m | tr -d '\\n'\")<cr>")
keymap("i", "OID", "<c-r>=system(\"oid | tr -d '\\n'\")<cr>")
keymap("i", "PWG", "<c-r>=system(\"pwgen -sBy1 40 | tr -d '\\n'\")<cr>")
keymap("i", "PWD", '<c-r>=expand("%")<cr>')

-- moving lines
keymap("n", "<A-j>", ":m .+1<CR>==")
keymap("n", "<A-k>", ":m .-2<CR>==")
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- keymap("n", "<leader>fd", "<cmd>Files <c-r>=expand('%:h')<cr><cr>")
-- keymap("n", "<leader>sg", [[<cmd>RG <c-r>=expand("<cword>")<cr>]], { desc = "::Rg word cursor" })
-- keymap("n", "<leader>sg", [[<cmd>RG <c-r><c-w><cr>]], { desc = "::Rg word cursor" })

keymap("n", "<leader>sg", function()
    local word = vim.fn.expand('<cword>')
    vim.cmd("RG " .. word)
end, { desc = "RG word cursor" })

keymap("n", "<leader>sb", function()
    local word = vim.fn.expand('<cword>')
    vim.cmd("RGw " .. word)
end, { desc = "RG -w 'word' boundaries cursor" })

-- keymap("n", "<leader>fd", function()
--     local dir = vim.fn.expand('%:h')
--     vim.cmd("Files " .. dir)
-- end, { desc = "fzf neighbor" })

keymap("n", "<leader>fd", vim.cmd.FdOne, { desc = "fzf neighbor depth 1" })
keymap("n", "<leader>fe", vim.cmd.FdAll, { desc = "fzf neighbor" })

vim.cmd([[
   " nnoremap <silent> <Leader>sr :RG \b<C-R><C-W>\b<CR>
   " nnoremap <silent> <Leader>sg :Rg \b<C-R><C-W>\b<CR>
   " autocmd VimEnter * nnoremap <silent> <Leader>fd :Files <C-R>=expand('%:h')<CR><CR>
   command W :execute ':silent w !sudo tee % > /dev/null' | :edit! 
]])

-- reload snippets
-- keymap('n', '<leader><leader>s', "<cmd>source ~/.config/nvim/lua/rods/plugins/luasnip.lua<cr>")

-- commands with preserve
-- disabled because when at the end of a word, yiw do not work
-- keymap('n', 'yip', [[ :lua preserve('normal! yip')<CR>2h ]], opts)
-- keymap('n', 'yiw', [[ :lua preserve('normal! yiw')<CR> ]])
-- keymap('n', '<space>==', [[ :lua preserve('normal! gg=G')<CR>2h ]], opts)

-- keymap("n", "<Up>", "<C-w><up>")
-- keymap("o", "<Up>", "<C-w><up>")
-- keymap("n", "<Down>", "<C-w><down>")
-- keymap("o", "<Down>", "<C-w><down>")
-- keymap("n", "<Left>", "<C-w><left>")
-- keymap("o", "<Left>", "<C-w><left>")
-- keymap("n", "<Right>", "<C-w><right>")
-- keymap("o", "<Right>", "<C-w><right>")
