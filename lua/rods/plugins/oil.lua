return {
	"stevearc/oil.nvim",
	opts = {},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
		vim.keymap.set("n", "<leader>f-", "<cmd>lua require('oil').toggle_float()<cr>", { desc = "Oil float" })

		require("oil").setup({
			skip_confirm_for_simple_edits = true,
			float = {
				padding = 5,
			},
			-- ref.: https://github.com/Gelio/ubuntu-dotfiles/blob/master/universal/neovim/config/nvim/lua/plugins/file-tree.lua
			-- win_options = {
			-- 	winbar = "%f",
			-- },
		})
	end,
}
