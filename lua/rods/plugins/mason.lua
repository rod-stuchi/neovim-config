return {
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
        "mfussenegger/nvim-dap",
        "jose-elias-alvarez/null-ls.nvim",
        "rmagatti/goto-preview",
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()
        require("goto-preview").setup({
            width = 120,
            height = 20,
        })
        local lspconfig = require("lspconfig")
        local lsp_attach = function(client, bufnr)
            -- keybindings
        end
        local get_servers = require("mason-lspconfig").get_installed_servers
        for _, server_name in ipairs(get_servers()) do
            lspconfig[server_name].setup({
                -- on_attach = lsp_attach
            })
        end
        -- lspconfig.gopls.setup {}

        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below fun
        vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
        vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist)

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set("n", "<leader>lwl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set("n", "<leader>lD", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "<leader>lrn", vim.lsp.buf.rename, opts)
                vim.keymap.set({ "n", "v" }, "<leader>lca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>lf", function()
                    vim.lsp.buf.format({ async = true })
                end, opts)
            end,
        })
    end,
}
