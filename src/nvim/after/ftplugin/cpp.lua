vim.o.commentstring = "// %s"

vim.keymap.set("n", "<Leader>ub", ":!g++ % -g -o ~/dev/cp/main<CR>")
vim.keymap.set("n", "<Leader>ue", ":split<CR>:terminal ~/dev/cp/main<CR>")
