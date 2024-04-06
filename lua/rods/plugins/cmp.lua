return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp", event = { "InsertEnter", "CmdlineEnter" } },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{ "ray-x/cmp-treesitter" },
	},
	config = function()
		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end
		table.unpack = table.unpack or unpack -- 5.1 compatibility

		local luasnip = require("luasnip")
		local cmp = require("cmp")
		local cmp_select_opts = { behavior = cmp.SelectBehavior.Select, count = 1 }

		cmp.setup({
			completion = {
				completionopt = "menu,menuone,preview,noselect",
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "nvim_lsp_signature_help" },
			}, {
				{ name = "treesitter", keyword_length = 3 },
				{ name = "path", keyword_length = 3 },
			}, {
				{ name = "buffer", keyword_length = 3 },
			}),
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = {
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<c-k>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item(cmp_select_opts)
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<c-j>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						-- cmp.complete()
						cmp.select_next_item(cmp_select_opts)
					else
						fallback()
					end
				end, { "i", "s" }),
				["<c-l>"] = cmp.mapping(function()
					if luasnip.choice_active() then
						luasnip.change_choice(1)
					else
						cmp.confirm({ select = true })
					end
				end, { "i" }),
				["<C-p>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.select_prev_item(cmp_select_opts)
					end
				end),
				["<C-n>"] = cmp.mapping(function()
					if cmp.visible() then
						cmp.select_next_item(cmp_select_opts)
					end
				end),
			},
			window = {
				documentation = {
					max_height = 15,
					max_width = 60,
				},
			},
			formatting = {
				fields = { "abbr", "menu", "kind" },
				format = function(entry, item)
					local short_name = {
						nvim_lsp = "LSP",
						nvim_lua = "nvim",
					}

					local menu_name = short_name[entry.source.name] or entry.source.name

					item.menu = string.format("[%s]", menu_name)
					return item
				end,
			},
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
