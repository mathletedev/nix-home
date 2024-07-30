if vim.g.neovide then
	vim.g.neovide_padding_top = 8
	vim.g.neovide_padding_bottom = 8
	vim.g.neovide_padding_right = 8
	vim.g.neovide_padding_left = 8

	vim.g.neovide_transparency = 0.95

	vim.g.neovide_cursor_vfx_mode = "pixiedust"

	vim.api.nvim_set_keymap(
		"n",
		"<C-=>",
		":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>",
		{ silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<C-->",
		":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>",
		{ silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"<C-0>",
		":lua vim.g.neovide_scale_factor = 1<CR>",
		{ silent = true }
	)
end
