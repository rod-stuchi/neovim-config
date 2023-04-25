vim.api.nvim_create_augroup("Git", {})
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "COMMIT_EDITMSG",
    callback = function()
        vim.cmd("set spell spelllang=en_us")
        -- insert mode if line empty
        vim.api.nvim_win_set_cursor(0, { 1, 0 })
        if vim.fn.getline(1) == "" then
            vim.cmd("startinsert!")
        end
    end,
    group = "Git",
})

vim.api.nvim_create_augroup("highlight_yank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 400 })
    end,
    group = "highlight_yank"
})
