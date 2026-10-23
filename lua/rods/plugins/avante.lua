return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false, -- set this if you want to always pull the latest change
	opts = {
		-- add any opts here
		provider = "gemini-flash",
		auto_suggestions_provider = "gemini-flash",
		file_selector = {
			provider = "fzf",
			provider_opts = {},
		},
		providers = {
			openai = {
				-- endpoint = "https://api.openai.com/v1",
				endpoint = "http://192.168.2.10:8091/v1",
				model = "gpt-5.5-pro",
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 10000,
				},
				api_key_name = "OPENAI_API_KEY",
			},
			claude = {
				-- endpoint = "https://api.anthropic.com",
				endpoint = "http://192.168.2.10:8092",
				model = "claude-sonnet-5",
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 10000,
				},
				api_key_name = "ANTHROPIC_API_KEY",
				disable_tools = true,
				-- disable_tools = { "python" },
			},
			["gemini-flash"] = {
				-- endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
				__inherited_from = "gemini",
				endpoint = "http://192.168.2.10:8093/v1beta/models",
				model = "gemini-3.5-flash",
				extra_request_body = {
					timeout = 30000,
					temperature = 0.75,
					max_tokens = 10000,
				},
				api_key_name = "GOOGLE_API_KEY",
			},
			["gemini-pro"] = {
				__inherited_from = "gemini",
				endpoint = "http://192.168.2.10:8093/v1beta/models",
				model = "gemini-pro-latest",
				extra_request_body = {
					timeout = 30000,
					temperature = 0.75,
					max_tokens = 10000,
				},
				api_key_name = "GOOGLE_API_KEY",
			},
		},
		behaviour = {
			auto_suggestions = false, -- Set to true to enable Copilot-like ghost text
			use_cwd_as_project_root = true,
		},
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		{ "ColinKennedy/mega.cmdparse", dependencies = { "ColinKennedy/mega.logging" } },
		"nvim-tree/nvim-web-devicons",
		"ibhagwan/fzf-lua",
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
