return {
	{
		"neovim/nvim-lspconfig",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		config = function()
			vim.lsp.config("*", {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})
		end,
	},
	-- {
	-- "neovim/nvim-lspconfig",
	-- config = function()
	-- ["clangd"] = function()
	-- 	local alt_capabilities =
	-- 		require("cmp_nvim_lsp").default_capabilities()
	-- 	alt_capabilities.offsetEncoding = { "utf-16" }
	-- end

	-- lspconfig.html.setup {
	-- 	on_attach = lsp.on_attach,
	-- 	capabilities = lsp.capabilities,
	-- 	handlers = lsp.handlers,
	-- 	filetypes = { "html", "elixir", "heex" },
	-- }

	-- lspconfig.lua_ls.setup {
	-- 	on_attach = lsp.on_attach,
	-- 	capabilities = lsp.capabilities,
	-- 	handlers = lsp.handlers,
	-- 	settings = {
	-- 		Lua = {
	-- 			completion = { callSnippet = "Replace" },
	-- 			diagnostics = {
	-- 				disable = { "missing-fields" },
	-- 			},
	-- 			workspace = { checkThirdParty = false },
	-- 		},
	-- 	},
	-- }

	-- lspconfig.tailwindcss.setup {
	-- 	on_attach = lsp.on_attach,
	-- 	capabilities = lsp.capabilities,
	-- 	handlers = lsp.handlers,
	-- 	settings = {
	-- 		tailwindCSS = {
	-- 			includeLanguages = {
	-- 				elixir = "html-eex",
	-- 				heex = "html-eex",
	-- 			},
	-- 		},
	-- 	},
	-- }
	-- end,
	-- },
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {},
		},
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		opts = {
			code_action = {
				keys = { quit = "<Esc>" },
			},
			finder = {
				keys = {
					quit = "<Esc>",
					toggle_or_open = "<CR>",
				},
			},
			lightbulb = { enable = false },
			rename = {
				keys = { quit = "<Esc>" },
			},
		},
		keys = {
			{ "<Leader>h", ":Lspsaga hover_doc<CR>", silent = true },
			{ "<Leader>a", ":Lspsaga code_action<CR>", silent = true },
			{ "<Leader>r", ":Lspsaga rename<CR>", silent = true },
			{ "<Leader>d", ":Lspsaga finder<CR>", silent = true },
		},
	},
	{
		"ray-x/lsp_signature.nvim",
		opts = {
			bind = true,
			handler_opts = {
				border = "rounded",
			},
		},
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		opts = {},
	},
}
