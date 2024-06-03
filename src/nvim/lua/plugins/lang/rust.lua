return {
	{
		"mrcjkb/rustaceanvim",
		lazy = false,
		config = function()
			vim.api.nvim_create_autocmd(
				"BufWinEnter",
				{ command = "nnoremap <Leader>h :lua vim.lsp.buf.hover()<CR>", pattern = "*.rs" }
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
				{ command = "nnoremap <Leader>a :lua vim.cmd.RustLsp('codeAction')<CR>", pattern = "*.rs" }
			)
		end,
	},
}
