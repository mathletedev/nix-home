return {
	lsp = {
		on_attach = function(_, bufnr)
			vim.api.nvim_buf_set_option(
				bufnr,
				"omnifunc",
				"v:lua.vim.lsp.omnifunc"
			)
			local opts = { buffer = bufnr, silent = true }

			vim.keymap.set("n", "<Leader>h", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, opts)
		end,
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
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
