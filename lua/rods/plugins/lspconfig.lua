return {
	"neovim/nvim-lspconfig",
	config = function()
		local navic = require("nvim-navic")
		local wk = require("which-key")
		local snacks = require("snacks")
		table.unpack = table.unpack or unpack -- 5.1 compatibility

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		local on_attach = function(client, bufnr)
			-- Server-specific capability modifications
			-- Use config.name for the lspconfig server name (e.g., "ts_ls")
			local server_name = client.config and client.config.name or client.name
			-- print("DEBUGPRINT[1 👜👜 ]: lspconfig.lua:13: server_name=", vim.inspect(server_name))

			-- Disable formatting for servers where we use external formatters
			if server_name == "ts_ls" or server_name == "prismals" then
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end

			-- Disable hover for ruff (prefer other Python LSPs)
			if server_name == "ruff" then
				client.server_capabilities.hoverProvider = false
			end

			-- Attach navic for document symbols
			if client.server_capabilities.documentSymbolProvider then
				navic.attach(client, bufnr)
			end
		end

		-- Configure each server individually to ensure on_attach is applied
		local servers = {
			"dartls",
			"gopls",
			"harper_ls",
			"lua_ls",
			"prismals",
			"ruby_lsp",
			"ruff",
			"rust_analyzer",
			"tailwindcss",
			"terraformls",
			"tflint",
			"ts_ls",
		}

		-- Set default config for all servers
		for _, server_name in ipairs(servers) do
			vim.lsp.config(server_name, {
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end

		-- Enable LSP servers (configs from after/lsp/*.lua are auto-merged)
		vim.lsp.enable(servers)

		-- ================ LSP ATTACH ================
		-- Global mappings.
		-- See `:help vim.diagnostic.*` for documentation on any of the below fun
		-- _stylua: ignore start
		local _icon = { icon = "", color = "orange" }
		wk.add({
			{ "<leader>l", group = "LSP", icon = _icon },
			{ "<leader>ln", "<cmd>Navbuddy<cr>", desc = "navbuddy" },
			{ "<leader>ld", vim.diagnostic.open_float, desc = "diagnostic open float", icon = _icon },
			{ "<leader>lq", vim.diagnostic.setloclist, desc = "set loclist", icon = _icon },
			{ "[d", vim.diagnostic.goto_prev, desc = "diagnostic prev", icon = _icon },
			{ "]d", vim.diagnostic.goto_next, desc = "diagnostic next", icon = _icon },
		})
		-- _stylua: ignore end

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				-- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions

				-- _stylua: ignore start
				wk.add({
					{ "gD", vim.lsp.buf.declaration, desc = "declaration", icon = _icon, buffer = ev.buf },
					{ "gd", vim.lsp.buf.definition, desc = "definition", icon = _icon, buffer = ev.buf },
					{ "K", vim.lsp.buf.hover, desc = "hover", icon = _icon, buffer = ev.buf },
					{ "<C-k>", vim.lsp.buf.signature_help, desc = "signature help", icon = _icon, buffer = ev.buf },
				})

				wk.add({
					-- { "<leader>lr", vim.lsp.buf.references, desc = "references", icon = _icon, buffer = ev.buf },
					{
						"<leader>lr",
						snacks.picker.lsp_references,
						desc = "references",
						icon = _icon,
						buffer = ev.buf,
					},
					{
						"<leader>li",
						vim.lsp.buf.implementation,
						desc = "implementation",
						icon = _icon,
						buffer = ev.buf,
					},
					{
						"<leader>lf",
						function()
							vim.lsp.buf.format({ async = true })
						end,
						desc = "format",
						icon = _icon,
						buffer = ev.buf,
					},
					{
						"<leader>lh",
						function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end,
						desc = "toggle inlay hint",
						icon = _icon,
						buffer = ev.buf,
					},
					{
						"<leader>la",
						vim.lsp.buf.code_action,
						desc = "code actions",
						mode = { "n", "v" },
						icon = _icon,
						buffer = ev.buf,
					},
					{
						"<leader>lA",
						function()
							vim.lsp.buf.code_action({
								context = { only = { "source" }, diagnostics = {} },
							})
						end,
						desc = "source actions",
						icon = _icon,
						buffer = ev.buf,
					},
					{
						"<leader>lR",
						vim.lsp.buf.rename,
						desc = "rename",
						icon = _icon,
						buffer = ev.buf,
					},
					{
						"<leader>lD",
						vim.lsp.buf.type_definition,
						desc = "type definition",
						icon = _icon,
						buffer = ev.buf,
					},
				})

				wk.add({
					{ "<leader>lw", group = "workspace" },
					{
						"<leader>lwa",
						vim.lsp.buf.add_workspace_folder,
						desc = "add workspace folder",
						icon = _icon,
						buffer = ev.buf,
					},
					{
						"<leader>lwr",
						vim.lsp.buf.remove_workspace_folder,
						desc = "remove workspace folder",
						icon = _icon,
						buffer = ev.buf,
					},
					{
						"<leader>lwl",
						function()
							print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
						end,
						desc = "list workspace folders",
						icon = _icon,
						buffer = ev.buf,
					},
				})
				-- _stylua: ignore end
			end,
		})
	end,
}
