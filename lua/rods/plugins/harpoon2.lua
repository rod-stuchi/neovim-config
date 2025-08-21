return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<C-i>", function()
			harpoon:list():add()
		end, { desc = "Harpoon add" })
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon menu" })

		vim.keymap.set("n", ",a", function()
			harpoon:list():select(1)
		end, { desc = "Harpoon 1" })
		vim.keymap.set("n", ",s", function()
			harpoon:list():select(2)
		end, { desc = "Harpoon 2" })
		vim.keymap.set("n", ",d", function()
			harpoon:list():select(3)
		end, { desc = "Harpoon 3" })
		vim.keymap.set("n", ",f", function()
			harpoon:list():select(4)
		end, { desc = "Harpoon 4" })
		vim.keymap.set("n", ",g", function()
			harpoon:list():select(5)
		end, { desc = "Harpoon 5" })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-P>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-N>", function()
			harpoon:list():next()
		end)
	end,
}
