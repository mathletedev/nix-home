vim.g.mapleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "<Leader>w", "<C-w>k")
vim.keymap.set("n", "<Leader>a", "<C-w>h")
vim.keymap.set("n", "<Leader>s", "<C-w>j")
vim.keymap.set("n", "<Leader>d", "<C-w>l")

vim.keymap.set("n", "<Leader>j", ":bprevious<CR>", { silent = true })
vim.keymap.set("n", "<Leader>k", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<Leader>q", ":bprevious<CR>:bdelete #<CR>", { silent = true })

vim.keymap.set("n", "<Leader>y", ":%y<CR>")

vim.keymap.set("n", "k", "gk", { silent = true })
vim.keymap.set("n", "j", "gj", { silent = true })

vim.keymap.set("n", "<Leader>l", ":vsplit term://fish <CR>", { silent = true })
vim.keymap.set("t", "<Leader><Esc>", "<C-\\><C-n>", { silent = true })

vim.keymap.set("n", "<Leader>n", require("telescope").extensions.file_browser.file_browser)
vim.keymap.set("n", "<Leader>f", require("telescope.builtin").find_files)
vim.keymap.set("n", "<Leader>t", require("telescope.builtin").treesitter)

vim.keymap.set({ "n", "v" }, "<Leader>c", ":Commentary<CR>", { silent = true })

vim.keymap.set("n", "<Leader>o", require("dap").toggle_breakpoint)
vim.keymap.set("n", "<Leader>p", require("dap").continue)
local dap_close = function()
	require("dap").terminate()
	require("dapui").close()
end
vim.keymap.set("n", "<Leader>[", dap_close)

vim.keymap.set("n", "<Leader>x", require("lsp_lines").toggle)
