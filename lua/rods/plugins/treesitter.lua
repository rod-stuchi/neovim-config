return {
	"nvim-treesitter/nvim-treesitter",
	-- The plugin does not support lazy-loading [1]
	lazy = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	-- Simplified build command to ensure parsers are updated [1]
	build = ":TSUpdate",
	config = function()
		-- 1. ts_context_commentstring remains independent
		require("ts_context_commentstring").setup({
			enable_autocmd = false,
			languages = {
				typescript = "// %s",
			},
		})

		-- 2. Install parsers directly using the new API [1]
		require("nvim-treesitter").install({
			"bash",
			"c",
			"css",
			"diff",
			"dockerfile",
			"elixir",
			"erlang",
			"go",
			"graphql",
			"hcl",
			"http",
			"javascript",
			"jq",
			"json",
			"latex",
			"lua",
			"luadoc",
			"make",
			"python",
			"regex",
			"rst",
			"ruby",
			"rust",
			"scss",
			"sql",
			"svelte",
			"terraform",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vue",
			"yaml",
		})

		-- Highlighting and indentation via native Neovim autocommands
		-- Large file handling delegated to snacks.bigfile (> 1.5 MB)
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local buf = args.buf
				local lang = vim.bo[buf].filetype

				if lang ~= "latex" then
					pcall(vim.treesitter.start, buf)
					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
