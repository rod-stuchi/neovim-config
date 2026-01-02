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

		-- Check if 'standard' gem is in Gemfile
		local function has_standard_installed_gemfile()
			local gemfile_path = vim.fn.getcwd() .. "/Gemfile"
			if vim.fn.filereadable(gemfile_path) == 0 then
				return false
			end
			local gemfile = vim.fn.readfile(gemfile_path)
			for _, line in ipairs(gemfile) do
				if line:match("gem%s+[\"']standard[\"']") then
					return true
				end
			end
			return false
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

				-- Rails *****************************************************************
				-- Dynamically use standardrb if 'standard' gem is in Gemfile, otherwise use rubocop
				has_standard_installed_gemfile() and null_ls.builtins.diagnostics.standardrb
					or null_ls.builtins.diagnostics.rubocop,
				has_standard_installed_gemfile() and null_ls.builtins.formatting.standardrb
					or null_ls.builtins.formatting.rubocop,
				-- Rails *****************************************************************
				-- ================================================================================

				-- ================================================================================
			},
		})
	end,
}
