return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local harpoon = require "harpoon"
			harpoon:setup {}

			vim.keymap.set("n", "<Leader>m", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<Leader>p", function()
				harpoon.ui:toggle_quick_menu(harpoon:list(), {
					border = "rounded",
					title_pos = "center",
					ui_width_ratio = 0.40,
				})
			end)

			for i = 0, 9 do
				vim.keymap.set("n", "<Leader>" .. i, function()
					harpoon:list():select(i)
				end)
			end
		end,
	},
}
