return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			local telescope = require "telescope"
			telescope.setup {
				defaults = {
					mappings = { n = { ["o"] = require("telescope.actions").select_default } },
					initial_mode = "normal",
					file_ignore_patterns = { ".git/" },
				},
				pickers = { find_files = { hidden = true } },
				extensions = { file_browser = { hidden = true } },
			}

			telescope.load_extension "file_browser"

			vim.keymap.set("n", "<Leader>n", require("telescope").extensions.file_browser.file_browser)
			vim.keymap.set("n", "<Leader>f", require("telescope.builtin").find_files)
			vim.keymap.set("n", "<Leader>t", require("telescope.builtin").treesitter)
		end,
	},
}
