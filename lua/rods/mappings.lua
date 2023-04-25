-- vim: fdm=marker:foldlevel=1:
-- vim.api.nvim_commnad("command! TSRehighlight :write | edit | TSBufEnable hightlight")

local keymap = vim.keymap.set

keymap({'n', 'v'}, ';', ':')
keymap({'n', 'v'}, ':', ';')

keymap('n', 'Q', '<nop>')

keymap('n', '<BS>', '<cmd>noh<cr>')
keymap('n', '<M-o>', '<cmd>copen<cr>')
keymap('n', '<M-O>', '<cmd>cclose<cr>')
keymap('n', '<M-[>', '<cmd>cprevious<cr>')
keymap('n', '<M-]>', '<cmd>cnext<cr>')

keymap('n', '<Up>', '<C-w><up>')
keymap('o', '<Up>', '<C-w><up>')
keymap('n', '<Down>', '<C-w><down>')
keymap('o', '<Down>', '<C-w><down>')
keymap('n', '<Left>', '<C-w><left>')
keymap('o', '<Left>', '<C-w><left>')
keymap('n', '<Right>', '<C-w><right>')
keymap('o', '<Right>', '<C-w><right>')


