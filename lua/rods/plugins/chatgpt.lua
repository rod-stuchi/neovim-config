return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	enabled = false,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("chatgpt").setup({
			-- api_key_cmd = "gpg --quiet -d /disks/Vault/Secret_Files/openai.gpg",
			-- api_key_cmd = "keepassxc-cli show -s -a Password --no-password -k ${TEMP_KPXC} /disks/Vault/KeePassXC/Default/SafeKeys.kdbx OpenAI",
			-- api_key_cmd = "cat /disks/Vault/Secret_Files/openai",
			openai_params = {
				model = "gpt-4o",
				frequency_penalty = 0,
				presence_penalty = 0,
				max_tokens = 4095,
				-- temperature = 0.2,
				temperature = 0.7,
				top_p = 0.1,
				n = 1,
			},
			openai_edit_params = {
				model = "gpt-4o",
				temperature = 0.7,
			},
		})
	end,
}
