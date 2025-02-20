vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<CR>",
	"<cmd>lua require('kulala').run()<cr>",
	{ noremap = true, silent = true, desc = "Execute the request" }
)

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"[",
	"<cmd>lua require('kulala').jump_prev()<cr>zt",
	{ noremap = true, silent = true, desc = "Jump to the previous request" }
)
vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"]",
	"<cmd>lua require('kulala').jump_next()<cr>zt",
	{ noremap = true, silent = true, desc = "Jump to the next request" }
)

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<leader>kd",
	"<cmd>lua require('kulala').download_graphql_schema()<cr>",
	{ noremap = true, silent = true, desc = "Download GraphQL schema definitions" }
)

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<leader>kc",
	"<cmd>lua require('kulala').copy()<cr>",
	{ noremap = true, silent = true, desc = "Copy to CURL" }
)

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<leader>kp",
	"<cmd>lua require('kulala').from_curl()<cr>",
	{ noremap = true, silent = true, desc = "Paste from CURL" }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>kt",
	":lua require('kulala').toggle_view()<CR>",
	{ noremap = true, silent = true, desc = "toggle view header / body" }
)

vim.api.nvim_buf_set_keymap(
	0,
	"n",
	"<leader>ki",
	"<cmd>lua require('kulala').inspect()<cr>",
	{ noremap = true, silent = true, desc = "Inspect the current request" }
)
