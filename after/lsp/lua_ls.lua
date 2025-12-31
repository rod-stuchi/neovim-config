return {
	settings = {
		Lua = {
			format = { enable = false },
			runtime = { version = "LuaJIT" },
			diagnostics = {
				globals = { "vim", "require" },
			},
		},
	},
}
