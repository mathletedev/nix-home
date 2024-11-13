return {
	lsp = {
		on_attach = function(_, bufnr)
			if bufnr == nil then
				bufnr = vim.fn.bufnr()
			end

			vim.api.nvim_buf_set_option(
				bufnr,
				"omnifunc",
				"v:lua.vim.lsp.omnifunc"
			)
			local opts = { buffer = bufnr, silent = true }

			vim.keymap.set("n", "<Leader>h", ":Lspsaga hover_doc<CR>", opts)
			vim.keymap.set("n", "<Leader>a", ":Lspsaga code_action<CR>", opts)
			vim.keymap.set("n", "<Leader>r", ":Lspsaga rename<CR>", opts)
			vim.keymap.set("n", "<Leader>d", ":Lspsaga finder<CR>", opts)
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
