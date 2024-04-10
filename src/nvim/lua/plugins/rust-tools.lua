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
				{ command = "nnoremap <Leader>gd :lua vim.lsp.buf.definition()<CR>", pattern = "*.rs" }
			)
			vim.api.nvim_create_autocmd(
				"BufWinEnter",
				{ command = "nnoremap <Leader>gi :lua vim.lsp.buf.implementation()<CR>", pattern = "*.rs" }
			)
			vim.api.nvim_create_autocmd(
				"BufWinEnter",
				{ command = "nnoremap <Leader>gr :lua vim.lsp.buf.references()<CR>", pattern = "*.rs" }
			)
			vim.api.nvim_create_autocmd(
				"BufWinEnter",
				{ command = "nnoremap <Leader>r :Lspsaga rename<CR>", pattern = "*.rs" }
			)
			vim.api.nvim_create_autocmd(
				"BufWinEnter",
				{ command = "nnoremap <Leader>a :Lspsaga code_action<CR>", pattern = "*.rs" }
			)
		end,
	},
}
