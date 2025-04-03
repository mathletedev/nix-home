-- tooling plugins
return {
	-- formatting
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				astro = { "prettierd" },
				css = { "prettierd" },
				elixir = { "mix" },
				gdscript = { "gdformat" },
				go = { "gofmt" },
				haskell = { "ormolu" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				json = { "prettierd" },
				tex = { "tex" },
				lua = { "stylua" },
				mdx = { "prettierd" },
				-- ocaml = { "ocamlformat" },
				python = { "black" },
				rust = { "rustfmt" },
				svelte = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				verilog = { "verible" },
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
				tex = {
					command = "tex-fmt",
					args = "$FILENAME",
					stdin = false,
				},
				verible = {
					command = "verible-verilog-format",
					prepend_args = { "--indentation_spaces", "4" },
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
				astro = { "eslint_d" },
				javascript = { "eslint_d" },
				svelte = { "eslint_d" },
				typescript = { "eslint_d" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
