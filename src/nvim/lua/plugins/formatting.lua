return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				go = { "gofmt" },
				lua = { "stylua" },
				python = { "black" },
				rust = { "rustfmt" },
			},
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 500,
			},
		},
	},
	{
		"nvimdev/guard.nvim",
		dependencies = {
			"nvimdev/guard-collection",
		},
		config = function()
			local ft = require "guard.filetype"
			ft("typescript,javascript,json,css,yaml,astro,svelte"):fmt "prettier"

			require("guard").setup {
				fmt_on_save = true,
				lsp_as_default_formatter = true,
			}
		end,
	},
}
