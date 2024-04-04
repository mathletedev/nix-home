return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = "nvim-treesitter/nvim-treesitter-context",
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
					"cpp",
					"css",
					"dart",
					"gdscript",
					"go",
					"html",
					"java",
					"json",
					"lua",
					"make",
					"markdown",
					"nix",
					"python",
					"rust",
					"sql",
					"svelte",
					"tsx",
					"typescript",
					"yaml",
				},
				sync_install = false,
				highlight = { enable = true },
			}

			require("treesitter-context").setup {}
		end,
	},
}
