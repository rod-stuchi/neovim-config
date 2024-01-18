return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			-- debug = true,
			sources = {
				null_ls.builtins.formatting.stylua.with({
					extra_args = { "--indent-type", "Tabs", "--indent-width", "4", "--column-width", "120" },
				}),
				null_ls.builtins.formatting.prettier.with({
					extra_filetypes = { "toml" },
					prefer_local = "node_modules/.bin",
					extra_args = function(params)
						return params.options
							and params.options.tabSize
							and {
								"--tab-width",
								params.options.tabSize,
							}
					end,
				}),
				null_ls.builtins.formatting.black,
			},
		})
	end,
}
