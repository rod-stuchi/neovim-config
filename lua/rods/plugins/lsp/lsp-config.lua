local M = {}

function M.setup(server_name, lspconfig)
	if server_name == "lua_ls" then
		lspconfig[server_name].setup({
			settings = {
				Lua = {
					format = { enable = false },
					runtime = { version = "LuaJIT" },
					diagnostics = {
						globals = { "vim", "require", "awesome", "client" },
					},
				},
			},
		})
	end
	if server_name == "tsserver" then
		lspconfig[server_name].setup({
			on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
			end,
		})
	end
end

return M
