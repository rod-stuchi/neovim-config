return {
	"code-biscuits/nvim-biscuits",
	config = function()
		require("nvim-biscuits").setup({
			cursor_line_only = true,
			toggle_keybind = "<leader>wb",
			show_on_start = true,

			default_config = {
				max_length = 30,
				min_distance = 10,
				prefix_string = " 📎 ",
			},

			language_config = {
				dart = {
					disabled = true,
				},
				html = {
					prefix_string = " 🌐 ",
				},
				javascript = {
					prefix_string = " ✨ ",
					max_length = 80,
				},
				python = {
					disabled = true,
				},
				sql = {
					disabled = true
				},
				vimdoc = {
					disabled = true
				}
			},
		})
	end,
}
