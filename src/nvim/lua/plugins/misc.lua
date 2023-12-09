return {
	{
		"andweeb/presence.nvim",
		event = "VeryLazy",
		opts = {
			neovim_image_text = "Neovim",
			presence_log_level = "error",
			presence_editing_text = "Editing « %s »",
			presence_file_explorer_text = "Browsing files",
			presence_reading_text = "Reading  « %s »",
			presence_workspace_text = "Working on « %s »",
		},
	},
	{
		"folke/todo-comments.nvim",
		opts = {},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{ "nvim-lua/plenary.nvim", lazy = true },
	"romainl/vim-cool",
	"stevearc/dressing.nvim",
	{
		"tpope/vim-commentary",
		event = "VeryLazy",
		keys = {
			{ "<Leader>c", ":Commentary<CR>", mode = { "n", "v" } },
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
}
