return {
	{
		"mrcjkb/haskell-tools.nvim",
		ft = "haskell",
		config = function()
			vim.api.nvim_create_autocmd(
				"BufWinEnter",
				{ command = "nnoremap <Leader>h :lua vim.lsp.buf.hover()<CR>", pattern = "*.hs" }
			)
			vim.api.nvim_create_autocmd(
				"BufWinEnter",
				{ command = "nnoremap <Leader>gd :lua vim.lsp.buf.definition()<CR>", pattern = "*.hs" }
			)
			vim.api.nvim_create_autocmd(
				"BufWinEnter",
				{ command = "nnoremap <Leader>gi :lua vim.lsp.buf.implementation()<CR>", pattern = "*.hs" }
			)
			vim.api.nvim_create_autocmd(
				"BufWinEnter",
				{ command = "nnoremap <Leader>gr :lua vim.lsp.buf.references()<CR>", pattern = "*.hs" }
			)
			vim.api.nvim_create_autocmd(
				"BufWinEnter",
				{ command = "nnoremap <Leader>r :Lspsaga rename<CR>", pattern = "*.hs" }
			)
			vim.api.nvim_create_autocmd(
				"BufWinEnter",
				{ command = "nnoremap <Leader>a :Lspsaga code_action<CR>", pattern = "*.hs" }
			)
		end,
	},
}
