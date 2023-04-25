local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    require("rods.plugins.treesitter"),
    require("rods.plugins.treesitter-comment"),
    require("rods.plugins.comment"),
    require("rods.plugins.which-key"),
    require("rods.plugins.bufferline"),
    require("rods.plugins.vim-easy-align"),
    require("rods.plugins.nvim-notify"),
    require("rods.plugins.leap"),
    require("rods.plugins.nvim-biscuits"),
    require("rods.plugins.goto-preview"),
    require("rods.plugins.fidget"),
    require("rods.plugins.pretty-fold"),
    require("rods.plugins.vim-mark"),
    require("rods.plugins.gitsigns"),
    require("rods.plugins.nvim-ts-autotag"),
    -- file
    require("rods.plugins.rnvimr"),
    require("rods.plugins.fzf"),

    -- 🌈 theme, colors
    require("rods.themes.kanagawa"),
    require("rods.plugins.nvim-colorize"),
})

