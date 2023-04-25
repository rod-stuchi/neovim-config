return {
    "anuvyklack/pretty-fold.nvim",
    config = function()
        require("pretty-fold").setup({
            sections = {
                left = {
                    "content",
                },
                right = {
                    " ",
                    "number_of_folded_lines",
                    ": ",
                    "percentage",
                    " ",
                    function(config)
                        return config.fill_char:rep(3)
                    end,
                },
            },
            matchup_patterns = {
                { "^%s*do$", "end" }, -- `do ... end` blocks
                { "^%s*if", "end" },
                { "^%s*for", "end" },
                { "function%s*%(", "end" }, -- 'function(' or 'function ('
                { "{", "}" },
                { "%(", ")" }, -- % to escape lua pattern char
                { "%[", "]" }, -- % to escape lua pattern char
            },
        })
    end,
}
