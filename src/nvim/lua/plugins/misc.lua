-- miscellanous plugins
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
		"APZelos/blamer.nvim",
		config = function()
			vim.g.blamer_enabled = 1
		end,
	},
	{
		"folke/todo-comments.nvim",
		opts = {},
	},
	"HiPhish/rainbow-delimiters.nvim",
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
	-- markdown preview
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		opts = {},
	},
	{ "nvim-lua/plenary.nvim", lazy = true },
	-- hlsearch functionality
	"romainl/vim-cool",
	-- cool UI
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
