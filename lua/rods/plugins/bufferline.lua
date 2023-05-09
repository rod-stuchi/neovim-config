return {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    dependencies = "nvim-tree/nvim-web-devicons",
    init = function()
        require("bufferline").setup({
            options = {
                mode = "buffers", -- set to "tabs" to only show tabpages instead
                themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
                numbers = function(opts)
                    return string.format("%s", opts.lower(opts.ordinal))
                end,
                middle_mouse_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
                indicator = {
                    icon = "▎", -- this should be omitted if indicator style is not 'icon'
                    style = "icon",
                },
                modified_icon = "●",
                left_trunc_marker = "",
                right_trunc_marker = "",
                max_name_length = 18,
                max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
                truncate_names = true, -- whether or not tab names should be truncated
                tab_size = 18,
                diagnostics = "nvim_lsp", -- false | "nvim_lsp" | "coc",
                diagnostics_update_in_insert = false,
                --     -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    return "(" .. count .. ")"
                end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        highlight = "Directory",
                        separator = true,
                        -- text = "File Explorer",
                        text = function()
                            return vim.fn.getcwd()
                        end,
                        text_align = "left",
                    },
                },
                color_icons = true, -- whether or not to add the filetype icon highlights
                show_buffer_icons = true, -- disable filetype icons for buffers
                show_buffer_close_icons = false,
                show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
                show_close_icon = false,
                show_tab_indicators = true,
                show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
                persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                separator_style = "thin", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' },
                enforce_regular_tabs = false,
                always_show_bufferline = true,
            },
        })

        vim.keymap.set('n', '<A-,>', '<cmd>BufferLineMovePrev<cr>')
        vim.keymap.set('n', '<A-.>', '<cmd>BufferLineMoveNext<cr>')
        vim.keymap.set('n', '<A-(>', '<cmd>BufferLineCyclePrev<cr>')
        vim.keymap.set('n', '<A-)>', '<cmd>BufferLineCycleNext<cr>')

        vim.keymap.set('n', '<Leader>1', '<cmd>lua require("bufferline").go_to_buffer(1, true)<cr>')
        vim.keymap.set('n', '<Leader>2', '<cmd>lua require("bufferline").go_to_buffer(2, true)<cr>')
        vim.keymap.set('n', '<Leader>3', '<cmd>lua require("bufferline").go_to_buffer(3, true)<cr>')
        vim.keymap.set('n', '<Leader>4', '<cmd>lua require("bufferline").go_to_buffer(4, true)<cr>')
        vim.keymap.set('n', '<Leader>5', '<cmd>lua require("bufferline").go_to_buffer(5, true)<cr>')
        vim.keymap.set('n', '<Leader>6', '<cmd>lua require("bufferline").go_to_buffer(6, true)<cr>')
        vim.keymap.set('n', '<Leader>7', '<cmd>lua require("bufferline").go_to_buffer(7, true)<cr>')
        vim.keymap.set('n', '<Leader>8', '<cmd>lua require("bufferline").go_to_buffer(8, true)<cr>')
        vim.keymap.set('n', '<Leader>9', '<cmd>lua require("bufferline").go_to_buffer(9, true)<cr>')
        vim.keymap.set('n', '<Leader>$', '<cmd>lua require("bufferline").go_to_buffer(-1, true)<cr>')

    end,
}
