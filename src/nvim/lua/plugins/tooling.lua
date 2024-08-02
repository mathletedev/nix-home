-- tooling plugins
return {
	-- formatting
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
				javascriptreact = { "prettierd" },
				json = { "prettierd" },
				lua = { "stylua" },
				mdx = { "prettierd" },
				python = { "black" },
				rust = { "rustfmt" },
				svelte = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
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
	-- linting
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require "lint"

			lint.linters_by_ft = {
				astro = { "oxlint" },
				javascript = { "oxlint" },
				svelte = { "oxlint" },
				typescript = { "oxlint" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
