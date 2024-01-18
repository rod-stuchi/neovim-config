return {
	"neovim/nvim-lspconfig",
	config = function()
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
		local d = function(buf, desc)
			return { buffer = buf, desc = desc }
		end
		-- Global mappings.
		-- See `:help vim.diagnostic.*` for documentation on any of the below fun
		vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "  diagnostic open float" })
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "  diagnostic prev" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "  diagnostic next" })
		vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "  set loclist" })

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				-- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }

				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { table.unpack(opts), desc = "  declaration" })
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, d(ev.buf, "  definition"))
				vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, d(ev.buf, "  implementation"))
				vim.keymap.set("n", "<leader>lR", vim.lsp.buf.references, d(ev.buf, "  references"))
				vim.keymap.set("n", "K", vim.lsp.buf.hover, d(ev.buf, "  hover"))
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, d(ev.buf, "  signature help"))
				vim.keymap.set("n", "<leader>lD", vim.lsp.buf.type_definition, d(ev.buf, "  type definition"))
				vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, d(ev.buf, "  rename"))
				vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, d(ev.buf, "  code actions"))
				vim.keymap.set("n", "<leader>lf", function()
					vim.lsp.buf.format({ async = true })
				end, d(ev.buf, "  format"))
				vim.keymap.set(
					"n",
					"<leader>lwa",
					vim.lsp.buf.add_workspace_folder,
					d(ev.buf, "  add workspace folder")
				)
				vim.keymap.set(
					"n",
					"<leader>lwr",
					vim.lsp.buf.remove_workspace_folder,
					d(ev.buf, "  remove workspace folder")
				)
				vim.keymap.set("n", "<leader>lwl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, d(ev.buf, "  list workspace folders"))
			end,
		})
	end,
}
