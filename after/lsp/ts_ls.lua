local inlay_hints = {
	includeInlayParameterNameHints = "all",
	includeInlayFunctionParameterTypeHints = true,
	includeInlayVariableTypeHints = true,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayEnumMemberValueHints = true,
}

return {
	settings = {
		typescript = {
			inlayHints = inlay_hints,
		},
		javascript = {
			inlayHints = inlay_hints,
		},
	},
}
