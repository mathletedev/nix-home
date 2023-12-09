return {
	{
		"nvimdev/guard.nvim",
		dependencies = {
			"nvimdev/guard-collection",
		},
		config = function()
			local ft = require "guard.filetype"
			ft("python"):fmt "black"
			ft("go"):fmt "gofmt"
			ft("typescript,javascript,json,css,yaml,astro,svelte"):fmt "prettier"
			ft("rust"):fmt "rustfmt"
			ft("lua"):fmt "stylua"

			require("guard").setup {
				fmt_on_save = true,
				lsp_as_default_formatter = true,
			}
		end,
	},
}
