return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update { with_sync = true }()
		end,
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter.configs").setup {
				ensure_installed = {
					"arduino",
					"astro",
					"bash",
					"c",
					"clojure",
					"cpp",
					"css",
					"elixir",
					"gdscript",
					"gleam",
					"go",
					"haskell",
					"html",
					"hyprlang",
					"java",
					"json",
					"lua",
					"make",
					"markdown",
					"markdown_inline",
					"nix",
					-- "ocaml",
					"python",
					"rust",
					"sql",
					"svelte",
					"tcl",
					"tsx",
					"typescript",
					"verilog",
					"yaml",
				},
				sync_install = false,
				highlight = { enable = true },
			}
		end,
	},
}
