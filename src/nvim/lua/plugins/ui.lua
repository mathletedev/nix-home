return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.g.catppuccin_flavour = "mocha"
			vim.cmd.colorscheme "catppuccin"
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"akinsho/bufferline.nvim",
			"catppuccin/nvim",
		},
		config = function()
			require("bufferline").setup {
				options = {
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level, _, _)
						local icon = level:match "error" and " " or " "
						return " " .. icon .. count
					end,
					separator_style = "slant",
				},
			}

			-- <Leader>p used by harpoon
			-- vim.keymap.set(
			-- 	"n",
			-- 	"<Leader>p",
			-- 	":BufferLinePick<CR>",
			-- 	{ silent = true }
			-- )
			vim.keymap.set(
				"n",
				"<Leader>`",
				":BufferLineTogglePin<CR>",
				{ silent = true }
			)

			local cp = require("catppuccin.palettes").get_palette()
			local custom_catppuccin = require "lualine.themes.catppuccin"

			custom_catppuccin.normal.b.bg = cp.surface0
			custom_catppuccin.normal.c.bg = cp.base
			custom_catppuccin.insert.b.bg = cp.surface0
			custom_catppuccin.command.b.bg = cp.surface0
			custom_catppuccin.visual.b.bg = cp.surface0
			custom_catppuccin.replace.b.bg = cp.surface0
			custom_catppuccin.inactive.a.bg = cp.base
			custom_catppuccin.inactive.b.bg = cp.base
			custom_catppuccin.inactive.b.fg = cp.surface0
			custom_catppuccin.inactive.c.bg = cp.base

			require("lualine").setup {
				options = {
					theme = custom_catppuccin,
					component_separators = "|",
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = {
						{
							"mode",
							separator = { left = "" },
							right_padding = 2,
						},
					},
					lualine_b = {
						"filename",
						"branch",
						{ "diff", colored = false },
					},
					lualine_c = {},
					lualine_x = {},
					lualine_y = { "filetype", "progress" },
					lualine_z = {
						{
							"location",
							separator = { right = "" },
							left_padding = 2,
						},
					},
				},
				inactive_sections = {
					lualine_a = { "filename" },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
			}
		end,
	},
	{
		"DaikyXendo/nvim-material-icon",
		opts = {
			override_by_extension = {
				["gleam"] = {
					icon = "",
					color = "#ffaff3",
					name = "Gleam",
				},
			},
		},
	},
}
