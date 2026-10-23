-- NOTE: Specify the trigger character(s) used for luasnip
local trigger_text = ";"

return {
	"saghen/blink.cmp",
	enabled = true,
	version = "*",
	dependencies = {
		{ "L3MON4D3/LuaSnip", version = "v2.*" },
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = function(_, opts)
		local disabled_filetypes = {
			["TelescopePrompt"] = true,
			["minifiles"] = true,
			["snacks_picker_input"] = true,
		}

		opts.enabled = function()
			local filetype = vim.bo[0].filetype
			return not disabled_filetypes[filetype]
		end

		opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
			-- DOC: DYNAMICALLY PICKING PROVIDERS BY TREESITTER NODE/FILETYPE
			default = { "lsp", "path", "snippets", "buffer" },
			-- default = function(ctx)
			-- 	local default_sources = { "lsp", "path", "snippets", "buffer" }
			-- 	local success, node = pcall(vim.treesitter.get_node)
			-- 	if vim.bo.filetype == "lua" then
			-- 		return default_sources
			-- 	elseif
			-- 		success
			-- 		and node
			-- 		and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
			-- 	then
			-- 		return { "buffer", "patch" }
			-- 	else
			-- 		return default_sources
			-- 	end
			-- end,

			providers = {
				lsp = {
					name = "lsp",
					enabled = true,
					module = "blink.cmp.sources.lsp",
					-- disable fallback for lsp, breaks `trigger_text` for snippets
					-- fallbacks = { "snippets", "buffer" },
					score_offset = 90, -- the higher the number, the higher the priority
				},

				path = {
					name = "Path",
					enabled = true,
					module = "blink.cmp.sources.path",
					score_offset = 25,
					fallbacks = { "snippets", "buffer" },
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context)
							return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
						end,
						show_hidden_files_by_default = true,
					},
				},

				buffer = {
					name = "Buffer",
					enabled = true,
					max_items = 3,
					module = "blink.cmp.sources.buffer",
					min_keyword_length = 4,
					score_offset = 15, -- the higher the number, the higher the priority
				},

				-- INFO: https://github.com/linkarzu/dotfiles-latest/blob/main/neovim/neobean/lua/plugins/blink-cmp.lua
				snippets = {
					name = "snippets",
					enabled = true,
					max_items = 8,
					min_keyword_length = 2,
					module = "blink.cmp.sources.snippets",
					score_offset = 100, -- the higher the number, the higher the priority
					-- Only show snippets if I type the trigger_text characters, so
					-- to expand the "bash" snippet, if the trigger_text is ";" I have to
					should_show_items = function()
						local col = vim.api.nvim_win_get_cursor(0)[2]
						local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
						-- NOTE: remember that `trigger_text` is modified at the top of the file
						return before_cursor:match(trigger_text .. "%w*$") ~= nil
					end,
					-- After accepting the completion, delete the trigger_text characters
					-- from the final inserted text
					-- Modified transform_items function based on suggestion by `synic` so
					-- that the luasnip source is not reloaded after each transformation
					-- https://github.com/linkarzu/dotfiles-latest/discussions/7#discussion-7849902
					transform_items = function(_, items)
						local col = vim.api.nvim_win_get_cursor(0)[2]
						local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
						local trigger_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
						if trigger_pos then
							for _, item in ipairs(items) do
								if not item.trigger_text_modified then
									---@diagnostic disable-next-line: inject-field
									item.trigger_text_modified = true
									item.textEdit = {
										newText = item.insertText or item.label,
										range = {
											start = { line = vim.fn.line(".") - 1, character = trigger_pos - 1 },
											["end"] = { line = vim.fn.line(".") - 1, character = col },
										},
									}
								end
							end
						end
						return items
					end,
				},

				cmdline = {
					min_keyword_length = function(ctx)
						if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
							return 3
						end
						return 0
					end,
				},
			},
		})

		opts.cmdline = {
			completion = { menu = { auto_show = true } },
			sources = function()
				local type = vim.fn.getcmdtype()
				-- Search forward and backward
				if type == "/" or type == "?" then
					return { "buffer" }
				end
				-- Commands
				if type == ":" or type == "@" then
					return { "cmdline" }
				end
				return {}
			end,
			-- Add custom keymap for cmdline mode
			-- stylua: ignore
			keymap = {
				preset     = "cmdline",
				["<Up>"]   = { "select_prev", "fallback" },
				["<C-p>"]  = { "select_prev", "fallback" },
				["<C-k>"]  = { "select_prev", "fallback" },
				["<C-n>"]  = { "select_next", "fallback" },
				["<C-j>"]  = { "select_next", "fallback" },
				["<Down>"] = { "select_next", "fallback" },

				["<C-y>"]  = { "accept", "fallback" },
				["<C-l>"]  = { "accept_and_enter", "fallback" },
			},
		}

		opts.completion = {
			keyword = {
				range = "full",
			},
			-- trigger = {
			-- 	show_on_trigger_character = true,
			-- },
			menu = {
				border = "single",
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
				window = {
					border = "single",
				},
			},
			ghost_text = {
				enabled = true,
			},
		}

		opts.snippets = {
			preset = "luasnip",
			expand = function(snippet)
				require("luasnip").lsp_expand(snippet)
			end,
			active = function(filter)
				if filter and filter.direction then
					return require("luasnip").jumpable(filter.direction)
				end
				return require("luasnip").in_snippet()
			end,
			jump = function(direction)
				require("luasnip").jump(direction)
			end,
		}

		-- stylua: ignore
		opts.keymap = {
			preset        = "default",
			["<Tab>"]     = { "snippet_forward", "fallback" },
			["<S-Tab>"]   = { "snippet_backward", "fallback" },

			["<Up>"]      = { "select_prev", "fallback" },
			["<C-p>"]     = { "select_prev", "fallback" },
			["<C-k>"]     = { "select_prev", "fallback" },
			["<C-n>"]     = { "select_next", "fallback" },
			["<C-j>"]     = { "select_next", "fallback" },
			["<Down>"]    = { "select_next", "fallback" },

			["<CR>"]      = { "select_and_accept", "fallback" },
			["<C-l>"]     = { "select_and_accept", "fallback" },

			["<S-k>"]     = { "scroll_documentation_up", "fallback" },
			["<S-j>"]     = { "scroll_documentation_down", "fallback" },

			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"]     = { "hide", "fallback" },
		}

		return opts
	end,
}
