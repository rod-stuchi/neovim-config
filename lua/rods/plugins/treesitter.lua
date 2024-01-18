return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"theHamsta/nvim-treesitter-pairs",
	},
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })()
	end,
	config = function()
		-- JoosepAlviste/nvim-ts-context-commentstring
		require("ts_context_commentstring").setup({
			enable_autocmd = false,
			languages = {
				typescript = "// %s",
			},
		})
		require("nvim-treesitter.configs").setup({
			autotag = {
				enables = true,
			},
			ensure_installed = {
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
			},
			highlight = {
				enable = true,

				-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
				-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
				-- the name of the parser)
				-- list of language that will be disabled
				-- disable = { "c", "rust" },
				-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
				disable = function(lang, buf)
					local max_filesize = 300 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gn", -- set to `false` to disable one of the mappings
					scope_incremental = "go",
					node_incremental = "gn",
					node_decremental = "gm",
				},
			},
		})
	end,
}
