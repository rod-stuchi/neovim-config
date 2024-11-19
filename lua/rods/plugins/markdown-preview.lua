return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install",
	init = function()
		vim.cmd([[
		let g:mkdp_theme = 'light'
		let g:mkdp_port = '8099'
		let g:mkdp_browser = '/usr/bin/mimeo'
		]])
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	ft = { "markdown" },
}
