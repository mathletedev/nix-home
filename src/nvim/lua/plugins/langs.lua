-- language-specific plugins
return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {},
	},
	{
		"mrcjkb/haskell-tools.nvim",
		ft = "haskell",
	},
	{
		"mrcjkb/rustaceanvim",
		lazy = false,
	},
	{
		"nvim-flutter/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = true,
	},
}
