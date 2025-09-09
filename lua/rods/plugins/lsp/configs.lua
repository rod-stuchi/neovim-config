local M = {}
local lspconfig = require("lspconfig")

local function filter(arr, fn)
	if type(arr) ~= "table" then
		return arr
	end

	local filtered = {}
	for k, v in pairs(arr) do
		if fn(v, k, arr) then
			table.insert(filtered, v)
		end
	end

	return filtered
end

local function filterReactDTS(value)
	return string.match(value.targetUri, "%.d.ts") == nil
end

local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

function M.setup(server_name, on_attach)
	if server_name == "lua_ls" then
		return {
			settings = {
				Lua = {
					format = { enable = false },
					runtime = { version = "LuaJIT" },
					diagnostics = {
						globals = { "vim", "require" },
					},
				},
			},
		}
	end

	if server_name == "harper_ls" then
		return {
			settings = {
				["harper-ls"] = {
					linters = {
						spell_check = true,
						spelled_numbers = false,
						an_a = true,
						sentence_capitalization = false,
						unclosed_quotes = true,
						wrong_quotes = false,
						long_sentences = false,
						repeated_words = true,
						spaces = true,
						matcher = true,
						correct_number_suffix = true,
						number_suffix_capitalization = true,
						multiple_sequential_pronouns = true,
						linking_verbs = false,
						avoid_curses = true,
					},
					diagnosticSeverity = "hint", -- Can also be "information", "warning", or "error"
					codeActions = {
						forceStable = true,
					},
				},
			},
		}
	end

	if server_name == "ts_ls" then
		return {
			root_dir = lspconfig.util.root_pattern("package.json"),
			single_file_support = false,
			handlers = {
				-- ref.: https://github.com/typescript-language-server/typescript-language-server/issues/216
				["textDocument/definition"] = function(err, result, method, ...)
					if vim.tbl_islist(result) and #result > 1 then
						local filtered_result = filter(result, filterReactDTS)
						return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
					end

					vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
				end,
			},
			commands = {
				OrganizeImports = {
					organize_imports,
					description = "Organize Imports",
				},
			},
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
			on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
				on_attach(client, bufnr)
			end,
		}
	end

	if server_name == "dartls" then
		return {
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
		}
	end

	if server_name == "gopls" then
		return {
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
		}
	end

	if server_name == "denols" then
		return {
			root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
		}
	end

	if server_name == "prismals" then
		return {
			on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
				on_attach(client, bufnr)
			end,
		}
	end

	if server_name == "tailwindcss" then
		return {
			filetypes = {
				"aspnetcorerazor",
				"astro",
				"astro-markdown",
				"blade",
				"django-html",
				"edge",
				"eelixir",
				"ejs",
				"erb",
				"eruby",
				"gohtml",
				"gotmpl",
				"haml",
				"handlebars",
				"hbs",
				"html",
				"html-eex",
				"jade",
				"leaf",
				"liquid",
				"markdown",
				"mdx",
				"mustache",
				"njk",
				"nunjucks",
				"php",
				"razor",
				"slim",
				"twig",
				"css",
				"less",
				"postcss",
				"sass",
				"scss",
				"stylus",
				"sugarss",
				"javascript",
				"javascriptreact",
				"reason",
				"rescript",
				"typescript",
				"typescriptreact",
				"vue",
				"svelte",
			},
		}
	end

	if server_name == "ruff" then
		return {
			on_attach = function(client, bufnr)
				-- Disable hover in favor of Pylsp or other Python LSP
				client.server_capabilities.hoverProvider = false
				on_attach(client, bufnr)
			end,
			init_options = {
				settings = {
					-- Arguments passed to ruff
					args = {},
				},
			},
		}
	end
	return {}
end

return M
