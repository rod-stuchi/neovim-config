vim.g.mapleader = " "
vim.b.mapleader = " "

require("rods.globals")
require("rods.lazy")
require("rods.funcs")
require("rods.mappings")
require("rods.autocmds")
require("rods.options")

require("rods.plugins.snips.luasnip")
require("rods.abbreviation.abbrev").setup()
require("rods.funcs").setCustomHighLights()
require("rods.diagnostic")

-- vim.lsp.set_log_level("debug")
-- :lua vim.cmd('e'..vim.lsp.get_log_path())
