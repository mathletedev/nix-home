local port = os.getenv "GDScript_Port" or "6005"
---@diagnostic disable-next-line
local cmd = vim.lsp.rpc.connect("127.0.0.1", port)
local pipe = "/tmp/godot.pipe"

vim.lsp.start {
	name = "Godot",
	cmd = cmd,
	root_dir = vim.fs.dirname(
		vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]
	),
	on_attach = function(_, bufnr)
		vim.api.nvim_command("echo serverstart(\"" .. pipe .. "\")")

		require("core.common").lsp.on_attach(_, bufnr)
	end,
	handlers = {
		["textDocument/hover"] = vim.lsp.with(
			vim.lsp.handlers.hover,
			{ border = "rounded" }
		),
		["textDocument/signatureHelp"] = vim.lsp.with(
			vim.lsp.handlers.signature_help,
			{ border = "rounded" }
		),
	},
}
