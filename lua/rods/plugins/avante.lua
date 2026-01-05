return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false, -- set this if you want to always pull the latest change
	opts = {
		-- add any opts here
		mode = "legacy",
		provider = "gemini-flash",
		providers = {
			openai = {
				-- endpoint = "https://api.openai.com/v1",
				endpoint = "http://192.168.2.10:8091/v1",
				model = "gpt-4o",
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 10000,
				},
				api_key_name = "OPENAI_API_KEY",
			},
			claude = {
				-- endpoint = "https://api.anthropic.com",
				endpoint = "http://192.168.2.10:8092",
				model = "claude-sonnet-4-5-20250929",
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
				model = "gemini-3-flash-preview",
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
				model = "gemini-3-pro-preview",
				extra_request_body = {
					timeout = 30000,
					temperature = 0.75,
					max_tokens = 10000,
				},
				api_key_name = "GOOGLE_API_KEY",
			},
		},
		behaviour = {
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
		"nvim-tree/nvim-web-devicons",
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
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
