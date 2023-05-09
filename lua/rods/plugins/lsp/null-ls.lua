local M = {}

function M.setup()
	local null_ls = require("null-ls")
	null_ls.setup({
		-- debug = true,
		sources = {
			null_ls.builtins.formatting.stylua.with({
				extra_args = { "--indent-type", "Tabs", "--indent-width", "4", "--column-width", "120" },
			}),
		},
	})
end

return M
