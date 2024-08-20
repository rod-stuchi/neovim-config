-- vim: foldlevel=9
return {
	"folke/which-key.nvim",
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
		local wk = require("which-key")
		wk.setup({})

		-- hidden
		wk.add({
			{ "<leader><tab>", hidden = true, mode = { "o", "n", "v" } },
			{ "<leader>1", hidden = true },
			{ "<leader>2", hidden = true },
			{ "<leader>3", hidden = true },
			{ "<leader>4", hidden = true },
			{ "<leader>5", hidden = true },
			{ "<leader>6", hidden = true },
			{ "<leader>7", hidden = true },
			{ "<leader>8", hidden = true },
			{ "<leader>9", hidden = true },
			{ "<leader>$", hidden = true },
			{ "<leader>m", hidden = true },
			{ "<leader>n", hidden = true },
			{ "<leader>#", hidden = true },
			{ "<leader>*", hidden = true },
			{ "<leader>/", hidden = true },
			{ "<leader>?", hidden = true },
		})

		-- stylua: ignore start
		local buf_icon = { icon = "", color = "green"}
		wk.add({
			{ "<leader>b", group = "Buffers", icon = buf_icon },
			{ "<leader>bb", "<cmd>Buffers<cr>", desc = "fzf buffers", icon = buf_icon },
			{ "<leader>b<space>", "<cmd>BufferLinePick<cr>", desc = "bufferline pick", icon = buf_icon },
			{ "<leader>bl", "<cmd>BLines<cr>", desc = "fzf buffer lines", icon = buf_icon },
			{ "<leader>bd", "<cmd>BuffersDelete<cr>", desc = "fzf delete buffers", icon = buf_icon },
			{ "<leader>bx", "<cmd>BufferLinePickClose<cr>", desc = "bufferline pick close", icon = buf_icon },
			{ "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "bufferline toogle pin", icon = buf_icon },
			{ "<leader>bX", "<cmd>%bd|e#|bd#<cr>", desc = "close all except this", icon = buf_icon },
		})

		wk.add({
			{ "<leader>c", group = "Copy / Change", icon = { icon = "", color = "cyan" } },
			{ "<leader>cc", "<cmd>Commands<cr>", desc = "open Commands" },
			{ "<leader>cd", '<cmd>cd %:p:h<cr><cmd>echom "CD to [" . expand("%:p:h") . "]"<cr>', desc = "cd directory current path" },
			{ "<leader>cn", '<cmd>let @+=expand("%:t")<cr><cmd>echom "Copied: [" . expand("%:t") . "] use ctrl+v"<cr>', desc = "copy filename to clipboard" },
			{ "<leader>co", '<cmd>let @+=expand("%")<cr><cmd>echom "Copied: [" . expand("%") . "] use ctrl+v"<cr>', desc = "copy relative filepath to clipboard" },
			{ "<leader>cp", '<cmd>let @+=expand("%:p")<cr><cmd>echom "Copied: [" . expand("%:p") . "] use ctrl+v"<cr>', desc = "copy full filepath to clipboard" },
		})

		wk.add({
			{ "<leader>e", group = "Editing", icon = { icon = "", color = "yellow" } },
			{ "<leader>ea", "<plug>(EasyAlign)", desc = "EasyAlign" },
			{ "<leader>el", "<plug>(LiveEasyAlign)", desc = "LiveEasyAlign" },
			{ "<leader>ec", "<cmd>CccPick<cr>", desc = "Color Picker" },
			{ "<leader>ej", "<cmd>lua require('treesj').toggle()<cr>", desc = "Join Treesitter" },
		})

		wk.add({
			{ "<leader>f", group = "File", icon = { icon = "", color = "orange" } },
			{ "<leader>fr", "<cmd>RnvimrToggle<cr>", desc = "ranger" },
			{ "<leader>ff", "<cmd>Files<cr>", desc = "fzf files" },
			{ "<leader>fg", "<cmd>GFiles<cr>", desc = "fzf git files" },
			{ "<leader>ft", "<cmd>GFiles?<cr>", desc = "fzf git status" },
			{ "<leader>fs", group = "Git status" },
			{ "<leader>fsm", "<cmd>lua require('igs').qf_modified()<cr>", desc = "modified qf" },
			{ "<leader>fsa", "<cmd>lua require('igs').qf_added()<cr>", desc = "added qf" },
		})

		wk.add({
			{ "m", group = "bookmarks", icon = { icon = "󰃁", color = "green" } },
			{ "mm", "<cmd>BookmarksMark<cr>", desc = "Mark current line", mode = { "n", "v" } },
			{ "mo", "<cmd>BookmarksGoto<cr>", desc = "Go to bookmark", mode = { "n", "v" } },
			{ "ma", "<cmd>BookmarksCommands<cr>", desc = "Commands", mode = { "n", "v" } },
			{ "mg", "<cmd>BookmarksGotoRecent<cr>", desc = "Go to latest", mode = { "n", "v" } },
			{ "mt", "<cmd>BookmarksTree<cr>", desc = "Open BookmarkTree", mode = { "n", "v" } },
		})

		wk.add({
			{ "<leader>o", group = "Operations", icon = { icon = "", color = "cyan" }},
				-- abc = 12 ^12
				-- cde = 3 * 4 + 2
			{ "<leader>o1", "<cmd>w !/home/rods/.scripts/sum.sh<cr>", desc = "sum" },
			{ "<leader>o2", '<cmd>lang pt_BR.UTF-8<cr><cmd>let @@=strftime("%d/%b (%a)\\n")<cr><cmd>normal! p<cr><cmd>lang en_US.UTF-8<cr>', desc = "pt-br (dd/mmm (ddd))" },
			{ "<leader>o3", '<cmd>lang pt_BR.UTF-8<cr><cmd>let @@=strftime("%d/%m/%Y (%a)\\n")<cr><cmd>normal! p<cr><cmd>lang en_US.UTF-8<cr>', desc = "pt-br (dd/mm/yyyy (ddd))" },
			{ "<leader>o4", '<cmd>lang pt_BR.UTF-8<cr><cmd>let @@=strftime("%A, %d de %B de %Y\\n")<cr><cmd>normal! p<cr><cmd>lang en_US.UTF-8<cr>', desc = "pt-br (dddd, dd de mmmm de yyyy)" },
			{ "<leader>o5",  'i<c-r>=strftime("%Y-%m-%d")<cr><esc>', desc = "date yyyy-mm-dd" },
			{ "<leader>o6", '<cmd>lang en_US.UTF-8<cr><cmd>let @@=strftime("%d/%b (%a)\\n")<cr><cmd>normal! p<cr><cmd>lang en_US.UTF-8<cr>', desc = "en-us (dd/mmm (ddd))" },
			{ "<leader>o7", '<cmd>lang en_US.UTF-8<cr><cmd>let @@=strftime("%m/%d/%Y (%a)\\n")<cr><cmd>normal! p<cr><cmd>lang en_US.UTF-8<cr>', desc = "en-us (dd/mm/yyyy (ddd))" },
			{ "<leader>o8", '<cmd>lang en_US.UTF-8<cr><cmd>let @@=strftime("%A, %B %d, %Y\\n")<cr><cmd>normal! p<cr><cmd>lang en_US.UTF-8<cr>', desc = "en-us (dddd, mmmm dd, yyyy)" },
			{ "<leader>os", function() local path = vim.fn.stdpath("config") .. "/lua/rods/plugins/snips/luasnip.lua" vim.cmd("source " .. path) end,  desc = "Reload LuaSnips" },
			-- stylua: ignore end
		})

		wk.add({
			{ "<leader>r", group = "RGFlow", icon = { icon = "󰑑", color = "red" } },
			{ "<leader>s", group = "Search", icon = { icon = "", color = "blue" } },
		})

		wk.add({
			{ "<leader>t", group = "Trouble", icon = { icon = "󰠭", color = "yellow" } },
			{ "<leader>td", "<cmd>Trouble document_diagnostics<cr>", desc = "document diagnostics" },
			{ "<leader>tw", "<cmd>Trouble workspace_diagnostics<cr>", desc = "workspace diagnostics" },
			{ "<leader>tr", "<cmd>Trouble lsp_references<cr>", desc = "lsp references" },
			{ "<leader>tD", "<cmd>Trouble lsp_definitions<cr>", desc = "lsp definitions" },
			{ "<leader>tt", "<cmd>Trouble lsp_type_definitions<cr>", desc = "lsp type definitions" },
			{ "<leader>tR", "<cmd>TroubleRefresh<cr>", desc = "refresh" },
		})

		wk.add({
			{ "<leader>w", group = "Window", icon = { icon = "", color = "azure" } },
			{ "<leader>wb", "<cmd>lua require('nvim-biscuits').toggle_biscuits()<cr>", desc = "toggle bisbuits" },
			{ "<leader>wc", "<cmd>set cursorcolumn!<bar>set cursorline!<cr>", desc = "toggle column/line cursor" },
			{ "<leader>wl", "<cmd>set number!<bar>set list!<cr>", desc = "toggle list chars" },
			{ "<leader>wm", "<cmd>mksession! /tmp/vim-session.vim<cr><cmd>wincmd o<cr>", desc = "maximize window" },
			{ "<leader>wu", "<cmd>source /tmp/vim-session.vim<cr>", desc = "undo maximize" },
			{ "<leader>wr", "<cmd>set number!<bar>set relativenumber!<cr>", desc = "toggle relative number" },
			{ "<leader>wt", '<cmd>lua require("rods.funcs").toggle_transparency()<cr>', desc = "toggle transparency" },
		})

		-- normal non leader
		-- stylua: ignore start
		wk.add({
			{ "[c", desc = "Prev git hunk", icon = { icon = "󰊢", color = "red" } },
			{ "]c", desc = "Next git hunk", icon = { icon = "󰊢", color = "red" } },
			{ "gn", desc = "Treesitter: select " },
			{ "gp", group = " Goto Preview" },
			{ "gpd", '<cmd> lua require("goto-preview").goto_preview_definition()<cr>', desc = "definition" },
			{ "gpi", '<cmd> lua require("goto-preview").goto_preview_implementation()<cr>', desc = "implementation" },
			{ "gpp", '<cmd> lua require("goto-preview").close_all_win()<cr>', desc = "close all windows" },
			{ "gpt", '<cmd> lua require("goto-preview").goto_preview_type_definition()<cr>', desc = "type definition" },
		})
		-- stylua: ignore end
	end,
}
