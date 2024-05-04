return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				astro = { "prettierd" },
				css = { "prettierd" },
				gdscript = { "gdformat" },
				go = { "gofmt" },
				javascript = { "prettierd" },
				json = { "prettierd" },
				lua = { "stylua" },
				python = { "black" },
				rust = { "rustfmt" },
				svelte = { "prettierd" },
				typescript = { "prettierd" },
				yaml = { "prettierd" },
			},
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 500,
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
