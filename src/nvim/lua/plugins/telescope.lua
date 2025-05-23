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
					mappings = {
						n = {
							["o"] = require("telescope.actions").select_default,
						},
					},
					file_ignore_patterns = { ".git/" },
					prompt_prefix = "   ",
					selection_caret = "  ",
					entry_prefix = "  ",
					initial_mode = "normal",
					selection_strategy = "reset",
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.8,
						preview_cutoff = 80,
					},
					path_display = { "truncate" },
					winblend = 0,
					border = {},
					-- stylua: ignore
					borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					color_devicons = true,
				},
				extensions = { file_browser = { hidden = true } },
				pickers = { find_files = { hidden = true } },
			}

			-- https://github.com/nvim-telescope/telescope.nvim/issues/3436#issuecomment-2756267300
			-- FIX: delete when telescope fixes double border
			vim.api.nvim_create_autocmd("User", {
				pattern = "TelescopeFindPre",
				callback = function()
					vim.opt_local.winborder = "none"
					vim.api.nvim_create_autocmd("WinLeave", {
						once = true,
						callback = function()
							vim.opt_local.winborder = "rounded"
						end,
					})
				end,
			})

			telescope.load_extension "file_browser"

			vim.keymap.set(
				"n",
				"<Leader>f",
				require("telescope.builtin").find_files
			)
			vim.keymap.set(
				"n",
				"<Leader>t",
				require("telescope.builtin").treesitter
			)
		end,
	},
}
