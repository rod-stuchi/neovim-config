return {
	"neovim/nvim-lspconfig",
	config = function()
		local wk = require("which-key")
		table.unpack = table.unpack or unpack -- 5.1 compatibility

		local lspconfig = require("lspconfig")
		local get_servers = require("mason-lspconfig").get_installed_servers
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local servers = get_servers()
		table.insert(servers, "dartls")
		for _, server_name in ipairs(servers) do
			lspconfig[server_name].setup({
				capabilities = capabilities,
			})
			require("rods.plugins.lsp.helper.setup-lsp").setup(server_name, lspconfig)
		end

		-- ================ LSP ATTACH ================
		-- Global mappings.
		-- See `:help vim.diagnostic.*` for documentation on any of the below fun
		local _icon = { icon = "", color = "orange" }
		wk.add({
			{ "<leader>l", group = "LSP", icon = _icon },
			{ "<leader>ln", "<cmd>Navbuddy<cr>", desc = "navbuddy" },
			{ "<leader>ld", vim.diagnostic.open_float, desc = "diagnostic open float", icon = _icon },
			{ "<leader>lq", vim.diagnostic.setloclist, desc = "set loclist", icon = _icon },
			{ "[d", vim.diagnostic.goto_prev, desc = "diagnostic prev", icon = _icon },
			{ "]d", vim.diagnostic.goto_next, desc = "diagnostic next", icon = _icon },
		})

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				-- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions

				-- stylua: ignore start
				wk.add({
					{ "gD", vim.lsp.buf.declaration, desc = "declaration", icon = _icon, buffer = ev.buf},
					{ "gd", vim.lsp.buf.definition, desc = "definition", icon = _icon, buffer = ev.buf},
					{ "K", vim.lsp.buf.hover, desc = "hover", icon = _icon, buffer = ev.buf},
					{ "<C-k>", vim.lsp.buf.signature_help, desc = "signature help", icon = _icon, buffer = ev.buf},
				})

				wk.add({
					{ "<leader>lr", vim.lsp.buf.references, desc = "references", icon = _icon, buffer = ev.buf },
					{ "<leader>li", vim.lsp.buf.implementation, desc = "implementation", icon = _icon, buffer = ev.buf },
					{ "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, desc = "format", icon = _icon, buffer = ev.buf },
					{ "<leader>lh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, desc = "toggle inlay hint", icon = _icon, buffer = ev.buf },
					{ "<leader>la", vim.lsp.buf.code_action, desc = "code actions", mode = { "n", "v" }, icon = _icon, buffer = ev.buf },
					{ "<leader>lR", vim.lsp.buf.rename, desc = "rename", icon = _icon, buffer = ev.buf },
					{ "<leader>lD", vim.lsp.buf.type_definition, desc = "type definition", icon = _icon, buffer = ev.buf },
				})

				wk.add({
					{ "<leader>lw", group = "workspace" },
					{ "<leader>lwa", vim.lsp.buf.add_workspace_folder, desc = "add workspace folder", icon = _icon, buffer = ev.buf },
					{ "<leader>lwr", vim.lsp.buf.remove_workspace_folder, desc = "remove workspace folder", icon = _icon, buffer = ev.buf },
					{ "<leader>lwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "list workspace folders", icon = _icon, buffer = ev.buf },
				})
				-- stylua: ignore end
			end,
		})
	end,
}
