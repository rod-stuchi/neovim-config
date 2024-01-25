return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/github/awesome-flutter-snippets" } })
		luasnip.filetype_extend("ruby", { "rails" })
		luasnip.filetype_extend("typescript", { "javascript" })
	end,
}
