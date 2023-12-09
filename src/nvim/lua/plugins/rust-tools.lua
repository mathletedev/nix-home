return {
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		config = function()
			require("rust-tools").setup {
				server = { standalone = false },
				dap = {
					adapter = {
						id = "cppdbg",
						type = "executable",
						command = vim.fn.expand "$HOME/bin/OpenDebugAD7",
					},
				},
			}

			vim.api.nvim_create_autocmd(
				"BufWinEnter",
				{ command = "nnoremap <Leader>h :RustHoverActions<CR>", pattern = "*.rs" }
			)
			vim.api.nvim_create_autocmd(
				"BufWinEnter",
				{ command = "nnoremap <Leader>i :lua vim.lsp.buf.definition()<CR>", pattern = "*.rs" }
			)
			vim.api.nvim_create_autocmd(
				"BufWinEnter",
				{ command = "nnoremap <Leader>r :lua vim.lsp.buf.rename()<CR>", pattern = "*.rs" }
			)
			vim.api.nvim_create_autocmd(
				"BufWinEnter",
				{ command = "nnoremap <Leader>a :lua vim.lsp.buf.code_action()<CR>", pattern = "*.rs" }
			)
		end,
	},
}
