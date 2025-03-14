return {
	"mangelozzi/rgflow.nvim",
	config = function()
		require("rgflow").setup({
			default_trigger_mappings = true,
			default_ui_mappings = true,
			default_quickfix_mappings = true,

			-- WARNING !!! Glob for '-g *{*}' will not use .gitignore file: https://github.com/BurntSushi/ripgrep/issues/2252
			-- "--smart-case -g *.{*,py} -g !*.{min.js,pyc} --fixed-strings --no-fixed-strings --no-ignore -M 500"
			--stylua: ignore
			cmd_flags = (
				"--smart-case --fixed-strings --no-fixed-strings --ignore --max-columns 250"
				-- Exclude globs
				-- .. " -g !**/node_modules/"
				-- .. " -g !**/static/*/jsapp/"
				-- .. " -g !**/.next/static/**"
			),
		})
	end,
}
