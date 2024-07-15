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
				},
			},
		})
	end
	if server_name == "tsserver" then
		lspconfig[server_name].setup({
			settings = {
				typescript = {
					inlayHints = {
						includeInlayEnumMemberValueHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = false,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayEnumMemberValueHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = false,
					},
				},
			},
			on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
			end,
		})
	end
	if server_name == "dartls" then
		lspconfig[server_name].setup({
			init_options = {
				closingLabels = true,
				flutterOutline = true,
				onlyAnalyzeProjectsWithOpenFiles = true,
				outline = true,
				suggestFromUnimportedLibraries = true,
			},
			settings = {
				dart = {
					completeFunctionCalls = true,
					showTodos = true,
				},
			},
		})
	end
	if server_name == "gopls" then
		lspconfig[server_name].setup({
			settings = {
				gopls = {
					["ui.inlayhint.hints"] = {
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						constantValues = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
				},
			},
		})
	end
end

return M
