if vim.g.neovide then
	vim.o.guifont = "Cascadia Code:h12"
	vim.g.neovide_font_features = {
		["Cascadia Code"] = { "+ss01" },
	}

	vim.g.neovide_padding_top = 8
	vim.g.neovide_padding_bottom = 8
	vim.g.neovide_padding_right = 8
	vim.g.neovide_padding_left = 8

	vim.g.neovide_cursor_vfx_mode = "pixiedust"
end
