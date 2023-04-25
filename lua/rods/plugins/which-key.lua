vim.cmd([[
    nnoremap <silent> <Leader>sr :Rg \b<C-R><C-W>\b<CR>
    autocmd VimEnter * nnoremap <silent> <Leader>fd :Files <C-R>=expand('%:h')<CR><CR>
]])

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

        wk.register({
            ['<tab>'] = "which_key_ignore",
            ['1'] = "which_key_ignore",
            ['2'] = "which_key_ignore",
            ['3'] = "which_key_ignore",
            ['4'] = "which_key_ignore",
            ['5'] = "which_key_ignore",
            ['6'] = "which_key_ignore",
            ['7'] = "which_key_ignore",
            ['8'] = "which_key_ignore",
            ['9'] = "which_key_ignore",
            ['$'] = "which_key_ignore",
            b = {
                name = "Buffers",
                b = { "<cmd>Buffers<cr>", "fzf buffers" },
                p = { "<cmd>BufferLinePick<cr>", "bufferline pick" },
                x = { "<cmd>BufferLinePickClose<cr>", "bufferline pick close" },
            },
            f = {
                name = "File",
                d = "fzf neighbor", -- mappings.lua
                r = { "<cmd>RnvimrToggle<cr>", "ranger" },
                f = { "<cmd>Files<cr>", "fzf files" },
                g = { "<cmd>GFiles<cr>", "fzf git files" },
            },
            h = {
                name = "Gitsigns",
                s = "stage hunk", -- gitsigns.lua
                r = "reset hunk", -- gitsigns.lua
                S = "stage buffer", -- gitsigns.lua
                u = "undo stage hunk", -- gitsigns.lua
                R = "reset buffer", -- gitsigns.lua
                p = "preview hunk", -- gitsigns.lua
                b = "blame line", -- gitsigns.lua
                d = "diff index", -- gitsigns.lua
                D = "diff last commit ~", -- gitsigns.lua
                t = {
                    name = "Toggle",
                    b = "line blame", -- gitsigns.lua
                    d = "deleted", -- gitsigns.lua
                },
            },
            s = {
                name = "Search",
                r = "ripgrep word cursor", -- mappings.lua
            },
            w = {
                name = "Window",
                b = "toogle biscuits", -- nvim-bisbuits.lua
                c = { "<cmd>set cursorcolumn!<bar>set cursorline!<cr>", "toggle column color" },
                l = { "<Cmd>set number!<bar>set list!<cr>", "toggle list chars" },
                r = { "<Cmd>set number!<bar>set relativenumber!<cr>", "toggle relative number" },
                t = { '<cmd>lua require("rods.funcs").toggle_transparency()<cr>', "toggle transparency" },
            },
        }, { prefix = "<leader>" })

        wk.register({
            ['<tab>'] = "which_key_ignore",
            h = {
                name = "Gitsigns",
                s = "stage hunk", -- gitsigns.lua
                r = "reset hunk", -- gitsigns.lua
            },
        }, { prefix = "<leader>", mode = "v" })

        wk.register({
            ['<tab>'] = "which_key_ignore",
        }, { prefix = "<leader>", mode = "o" })

        wk.register({
            ["["] = {
                c = "prev git hunk", -- gitsigns.lua
            },
            ["]"] = {
                c = "next git hunk", -- gitsigns.lua
            },
            g = {
                p = {
                    name = "Goto Preview",
                    d = { '<cmd> lua require("goto-preview").goto_preview_definition()<cr>', "definition" },
                    t = { '<cmd> lua require("goto-preview").goto_preview_type_definition()<cr>', "type definition" },
                    i = { '<cmd> lua require("goto-preview").goto_preview_implementation()<cr>', "implementation" },
                    p = { '<cmd> lua require("goto-preview").close_all_win()<cr>', "close all windows" },
                },
            },
        })
    end,
}
