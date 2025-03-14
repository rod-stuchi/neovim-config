return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local ls = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/github/awesome-flutter-snippets" } })
		ls.filetype_extend("ruby", { "rails" })
		local filetypes = { "typescript", "typescriptreact", "vue", "svelte" }
		for _, ft in ipairs(filetypes) do
			ls.filetype_extend(ft, { "javascript" })
		end

		ls.config.set_config({
			store_selection_keys = "<Tab>", -- This key will be used to capture the selection
		})

		-- Load LuaSnip safely
		-- local status_ok, luasnip = pcall(require, "luasnip")
		-- if not status_ok then
		-- 	return
		-- end

		-- Snippet expansion keybindings (insert mode)
		-- vim.api.nvim_set_keymap(
		-- 	"i",
		-- 	"<C-k>",
		-- 	"<Cmd>lua require'luasnip'.jump(1)<CR>",
		-- 	{ silent = true, noremap = true }
		-- ) -- Jump to next
		-- vim.api.nvim_set_keymap(
		-- 	"i",
		-- 	"<C-j>",
		-- 	"<Cmd>lua require'luasnip'.jump(-1)<CR>",
		-- 	{ silent = true, noremap = true }
		-- ) -- Jump to previous

		-- -- Snippet expansion keybinding (Insert Mode, for expanding snippets)
		-- vim.api.nvim_set_keymap(
		-- 	"i",
		-- 	"<C-l>",
		-- 	"<Cmd>lua require'luasnip'.expand_or_jump()<CR>",
		-- 	{ silent = true, noremap = true }
		-- )

		-- -- Snippet expansion keybinding (Visual mode to expand a snippet that wraps selection)
		-- vim.api.nvim_set_keymap(
		-- 	"v",
		-- 	"<C-l>",
		-- 	"<Cmd>lua require'luasnip'.expand_or_jump()<CR>",
		-- 	{ silent = true, noremap = true }
		-- )

		-- You can also set shortcuts in normal mode for expanding snippets
	end,
}
