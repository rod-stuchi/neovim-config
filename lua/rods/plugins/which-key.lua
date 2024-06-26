-- vim: foldlevel=9
return {
	"folke/which-key.nvim",
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
		local wk = require("which-key")
		wk.setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		})

		-- normal leader
		wk.register({
			["<tab>"] = "which_key_ignore",
			["1"] = "which_key_ignore",
			["2"] = "which_key_ignore",
			["3"] = "which_key_ignore",
			["4"] = "which_key_ignore",
			["5"] = "which_key_ignore",
			["6"] = "which_key_ignore",
			["7"] = "which_key_ignore",
			["8"] = "which_key_ignore",
			["9"] = "which_key_ignore",
			["$"] = "which_key_ignore",
			b = {
				name = "󰅭  Buffers",
				["<space>"] = { "<cmd>BufferLinePick<cr>", "bufferline pick" },
				b = { "<cmd>Buffers<cr>", "fzf buffers" },
				l = { "<cmd>BLines<cr>", "fzf buffer lines" },
				d = { "<cmd>BuffersDelete<cr>", "fzf delete buffers" },
				x = { "<cmd>BufferLinePickClose<cr>", "bufferline pick close" },
				p = { "<cmd>BufferLineTogglePin<cr>", "bufferline toogle pin" },
				X = { "<cmd>%bd|e#|bd#<cr>", "close all except this" },
			},
			c = {
				name = "  Copy/Change",
				c = { '<cmd>Commands<cr>', 'open Commands' },
				d = { '<cmd>cd %:p:h<cr><cmd>echom "CD to [" . expand("%:p:h") . "]"<cr>', "cd directory current path" },
				n = {
					'<cmd>let @+=expand("%:t")<cr><cmd>echom "Copied: [" . expand("%:t") . "] use ctrl+v"<cr>',
					"copy filename to clipboard",
				},
				o = {
					'<cmd>let @+=expand("%")<cr><cmd>echom "Copied: [" . expand("%") . "] use ctrl+v"<cr>',
					"copy relative filepath to clipboard",
				},
				p = {
					'<cmd>let @+=expand("%:p")<cr><cmd>echom "Copied: [" . expand("%:p") . "] use ctrl+v"<cr>',
					"copy full filepath to clipboard",
				},
			},
			e = {
				name = "  Editing",
				a = { "<plug>(EasyAlign)", "EasyAlign" },
				l = { "<plug>(LiveEasyAlign)", "LiveEasyAlign" },
				c = { "<cmd>CccPick<cr>", "Color Picker" },
				j = { "<cmd>lua require('treesj').toggle()<cr>", "Join Treesitter" },
			},
			f = {
				name = "  File",
				r = { "<cmd>RnvimrToggle<cr>", "ranger" },
				f = { "<cmd>Files<cr>", "fzf files" },
				g = { "<cmd>GFiles<cr>", "fzf git files" },
				t = { "<cmd>GFiles?<cr>", "fzf git status" },
				s = {
					name = "Git status",
					m = { "<cmd>lua require('igs').qf_modified()<cr>", "modified qf" },
					a = { "<cmd>lua require('igs').qf_added()<cr>", "added qf" },
				},
			},
			h = {
				name = "  Gitsigns",
				s = "stage hunk", -- gitsigns.lua
				r = "reset hunk", -- gitsigns.lua
				S = "stage buffer", -- gitsigns.lua
				u = "undo stage hunk", -- gitsigns.lua
				R = "reset buffer", -- gitsigns.lua
				p = "preview hunk", -- gitsigns.lua
				b = "blame line", -- gitsigns.lua
				d = "diff index", -- gitsigns.lua
				D = "diff last commit ~", -- gitsigns.lua
				q = { "<cmd>Gitsigns setqflist<cr>", "set quickfix list" },
				t = {
					name = "Toggle",
					b = "line blame", -- gitsigns.lua
					d = "deleted", -- gitsigns.lua
				},
			},
			l = {
				name = "  LSP",
				w = "  workspace",
				n = { "<cmd>Navbuddy<cr>", "  navbuddy" },
			},
			o = {
				name = "  Operations",
				-- Math operations in lines, resolves line expression, and SUM, AVG all lines with description on left:
				-- abc = 12 ^12
				-- cde = 3 * 4 + 2
				["1"] = { "<cmd>w !/home/rods/.scripts/sum.sh<cr>", "sum" },
				["2"] = {
					'<cmd>lang pt_BR.UTF-8<cr><cmd>let @@=strftime("%d/%b (%a)\\n")<cr><cmd>normal! p<cr><cmd>lang en_US.UTF-8<cr>',
					"date pt-br (dd/mmm (ddd))",
				},
				["3"] = {
					'<cmd>lang pt_BR.UTF-8<cr><cmd>let @@=strftime("%d/%m/%Y (%a)\\n")<cr><cmd>normal! p<cr><cmd>lang en_US.UTF-8<cr>',
					"date pt-br (dd/mm/yyyy (ddd))",
				},
				["4"] = {
					'<cmd>lang pt_BR.UTF-8<cr><cmd>let @@=strftime("%A, %d de %B de %Y\\n")<cr><cmd>normal! p<cr><cmd>lang en_US.UTF-8<cr>',
					"date pt-br (dddd, dd de mmmm de yyyy)",
				},
				["5"] = { 'i<c-r>=strftime("%Y-%m-%d")<cr><esc>', "date yyyy-mm-dd" },
				s = {
					function()
						local path = vim.fn.stdpath("config") .. "/lua/rods/plugins/snips/luasnip.lua"
						vim.cmd("source " .. path)
					end,
					"Reload LuaSnips",
				},
			},
			r = {
				name = "󰑑  RGFlow",
			},
			s = {
				name = "  Search",
			},
			t = {
				name = "  Trouble",
				d = { "<cmd>Trouble document_diagnostics<cr>", "document diagnostics" },
				w = { "<cmd>Trouble workspace_diagnostics<cr>", "workspace diagnostics" },
				r = { "<cmd>Trouble lsp_references<cr>", "lsp references" },
				D = { "<cmd>Trouble lsp_definitions<cr>", "lsp definitions" },
				t = { "<cmd>Trouble lsp_type_definitions<cr>", "lsp type definitions" },
				R = { "<cmd>TroubleRefresh<cr>", "refresh" },
			},
			w = {
				name = "  Window",
				b = "toogle biscuits", -- nvim-bisbuits.lua
				c = { "<cmd>set cursorcolumn!<bar>set cursorline!<cr>", "toggle column color" },
				l = { "<cmd>set number!<bar>set list!<cr>", "toggle list chars" },
				m = { "<cmd>mksession! /tmp/vim-session.vim<cr><cmd>wincmd o<cr>", "maximize window" },
				u = { "<cmd>source /tmp/vim-session.vim<cr>", "undo maximize" },
				r = { "<cmd>set number!<bar>set relativenumber!<cr>", "toggle relative number" },
				t = { '<cmd>lua require("rods.funcs").toggle_transparency()<cr>', "toggle transparency" },
			},
		}, { prefix = "<leader>", mode = "n" })

		-- visual leader
		wk.register({
			["<tab>"] = "which_key_ignore",
			e = {
				name = "  Editing",
				a = { "<plug>(EasyAlign)", "EasyAlign" },
				l = { "<plug>(LiveEasyAlign)", "LiveEasyAlign" },
			},
			h = {
				name = "  Gitsigns",
				s = "stage hunk", -- gitsigns.lua
				r = "reset hunk", -- gitsigns.lua
			},
			r = {
				name = "󰑑  RGFlow",
				g = "open visual",
			},
		}, { prefix = "<leader>", mode = "v" })

		-- operation leader
		wk.register({
			["<tab>"] = "which_key_ignore",
		}, { prefix = "<leader>", mode = "o" })

		-- normal non leader
		wk.register({
			["["] = {
				c = "  Prev git hunk", -- gitsigns.lua
			},
			["]"] = {
				c = "  Next git hunk", -- gitsigns.lua
			},
			g = {
				n = "Treesitter: select ", -- NOTE: not working 
				p = {
					name = "  Goto Preview",
					d = { '<cmd> lua require("goto-preview").goto_preview_definition()<cr>', "definition" },
					t = { '<cmd> lua require("goto-preview").goto_preview_type_definition()<cr>', "type definition" },
					i = { '<cmd> lua require("goto-preview").goto_preview_implementation()<cr>', "implementation" },
					-- r = { '<cmd> lua require("goto-preview").goto_preview_references()<cr>', "references" },
					p = { '<cmd> lua require("goto-preview").close_all_win()<cr>', "close all windows" },
				},
			},
		})
	end,
}
