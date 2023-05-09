local M = {}

function M.setup(server_name, lspconfig)
	if server_name == "lua_ls" then
		lspconfig[server_name].setup({
			settings = {
				Lua = {
					format = { enable = false },
					runtime = { version = "LuaJIT" },
					diagnostics = {
						globals = { "vim", "require" },
					},
					-- workspace = {
					--     -- Make the server aware of Neovim runtime files
					--     library = vim.api.nvim_get_runtime_file("", true),
					-- },
				},
			},
		})
	end
end

return M
