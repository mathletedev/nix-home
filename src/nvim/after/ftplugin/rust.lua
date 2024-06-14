vim.keymap.set("n", "<Leader>h", vim.lsp.buf.hover)
vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<Leader>gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references)
vim.keymap.set("n", "<Leader>r", ":Lspsaga rename<CR>")
-- use string instead of function to allow rustaceanvim to load first
vim.keymap.set("n", "<Leader>a", ":RustLsp codeAction<CR>")
