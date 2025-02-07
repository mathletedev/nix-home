vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

vim.keymap.set("n", "<Leader>e", function()
	vim.fn.jobstart(
		{ "xdg-open", vim.fn.expand "%:p:r" .. ".pdf" },
		{ detach = true }
	)
end, { buffer = true })
