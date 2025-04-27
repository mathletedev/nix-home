vim.keymap.set("n", "<Leader>e", function()
	vim.fn.jobstart(
		{ "xdg-open", vim.fn.expand "%:p:r" .. ".pdf" },
		{ detach = true }
	)
end, { buffer = true })
