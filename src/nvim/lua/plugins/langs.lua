-- language-specific plugins
return {
	{
		"habamax/vim-godot",
		ft = "gdscript",
	},
	{
		"mrcjkb/haskell-tools.nvim",
		ft = "haskell",
	},
	{
		"mrcjkb/rustaceanvim",
		lazy = false,
		config = function()
			vim.g.rustaceanvim = {
				server = {
					handlers = {
						["textDocument/hover"] = vim.lsp.with(
							vim.lsp.handlers.hover,
							{ border = "rounded" }
						),
						["textDocument/signatureHelp"] = vim.lsp.with(
							vim.lsp.handlers.signature_help,
							{ border = "rounded" }
						),
					},
				},
			}
		end,
	},
	{
		"nvim-flutter/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = function()
			local lsp = require("core.common").lsp

			require("flutter-tools").setup {
				lsp = lsp,
			}
		end,
	},
}
