return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		local function get_local_bin_dynamic(cmd)
			local local_bin = vim.fn.getcwd() .. "/node_modules/.bin/" .. cmd
			if vim.fn.executable(local_bin) == 1 then
				return local_bin
			end
			return cmd -- fallback to global
		end

		null_ls.setup({
			-- debug = true,
			sources = {
				-- ================================================================================
				null_ls.builtins.formatting.stylua.with({
					extra_args = { "--indent-type", "Tabs", "--indent-width", "4", "--column-width", "120" },
				}),
				-- ================================================================================
				null_ls.builtins.formatting.prettierd,
				-- ================================================================================
				null_ls.builtins.formatting.prisma_format.with({
					command = get_local_bin_dynamic("prisma"),
					args = { "format" },
					extra_args = { "--schema", "prisma/schema.prisma" },
					to_temp_file = true,
				}),
				-- ================================================================================
				-- null_ls.builtins.formatting.black,
				-- ================================================================================
				null_ls.builtins.diagnostics.rubocop,
				null_ls.builtins.formatting.rubocop,
				-- ================================================================================
			},
		})

		null_ls.register({
			name = "my-actions",
			method = { require("null-ls").methods.CODE_ACTION },
			filetypes = { "typescriptreact" },
			generator = {
				fn = function()
					return {
						{
							title = "Organize Imports",
							action = function()
								vim.cmd([[ OrganizeImports ]])
							end,
						},
					}
				end,
			},
		})
	end,
}
