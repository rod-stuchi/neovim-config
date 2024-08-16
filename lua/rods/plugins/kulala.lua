return {
	"mistweaverco/kulala.nvim",
	config = function()
		-- Setup is required, even if you don't pass any options
		require("kulala").setup({
			-- default_view, body or headers
			default_view = "body",
			-- dev, test, prod, can be anything
			-- see: https://learn.microsoft.com/en-us/aspnet/core/test/http-files?view=aspnetcore-8.0#environment-files
			default_env = "dev",
			-- enable/disable debug mode
			debug = false,
			-- default formatters for different content types
			formatters = {
				json = { "jq", "." },
				xml = { "xmllint", "--format", "-" },
				html = { "xmllint", "--format", "--html", "-" },
			},
			-- default icons
			icons = {
				inlay = {
					loading = "⏳",
					done = "✅",
					error = "❌",
				},
				lualine = "🐼",
			},
			-- additional cURL options
			-- see: https://curl.se/docs/manpage.html
			additional_curl_options = {},
		})
	end,
}
