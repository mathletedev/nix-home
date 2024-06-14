-- formatting plugins
return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				astro = { "prettierd" },
				css = { "prettierd" },
				gdscript = { "gdformat" },
				go = { "gofmt" },
				haskell = { "ormolu" },
				javascript = { "prettierd" },
				json = { "prettierd" },
				lua = { "stylua" },
				python = { "black" },
				rust = { "rustfmt" },
				svelte = { "prettierd" },
				typescript = { "prettierd" },
				yaml = { "prettierd" },
			},
			format_after_save = {
				lsp_fallback = true,
				quiet = true,
			},
			formatters = {
				gdformat = {
					command = "gdformat",
					args = "$FILENAME",
					stdin = false,
				},
			},
		},
	},
}
