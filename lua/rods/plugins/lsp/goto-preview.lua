local M = {}

function M.setup()
	require("goto-preview").setup({
		width = 120,
		height = 20,
		opacity = 0,
	})
end

return M
