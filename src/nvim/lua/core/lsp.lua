vim.lsp.enable {
	"astro",
	"bashls",
	"clangd",
	"clojure_lsp",
	"cssls",
	"gopls",
	"html",
	"lexical",
	"lua_ls",
	"mdx_analyzer",
	"nil_ls",
	-- "ocamllsp",
	"pyright",
	"svelte",
	"tailwindcss",
	"texlab",
	"tinymist",
	"ts_ls",
	"verible",
	"yamlls",
}

vim.diagnostic.config {
	virtual_text = false,
	virtual_lines = {
		only_current_line = true,
	},
}

vim.fn.sign_define(
	"DiagnosticSignError",
	{ text = "●", texthl = "DiagnosticSignError" }
)
vim.fn.sign_define(
	"DiagnosticSignWarn",
	{ text = "●", texthl = "DiagnosticSignWarn" }
)
vim.fn.sign_define(
	"DiagnosticSignInfo",
	{ text = "●", texthl = "DiagnosticSignInfo" }
)
vim.fn.sign_define(
	"DiagnosticSignHint",
	{ text = "●", texthl = "DiagnosticSignHint" }
)
