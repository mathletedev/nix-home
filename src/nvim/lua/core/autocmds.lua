local lang_maps = {
	arduino = {
		build = "arduino-cli compile --fqbn arduino:avr:uno %",
		exec = "arduino-cli upload -p /dev/ttyACM0 --fqbn arduino:avr:uno %",
	},
	c = { build = "gcc *.c -lm -g -o main", exec = "./main" },
	clojure = { exec = "lein run" },
	cpp = {
		build = "mkdir -p build && cd build && cmake .. && make",
		exec = "cd build && ./main",
	},
	go = { build = "go build", exec = "go run %" },
	haskell = { exec = "cabal run" },
	java = { build = "javac %", exec = "java %:r" },
	javascript = { exec = "bun %" },
	python = { exec = "python %" },
	rust = { exec = "cargo run" },
	sh = { exec = "%" },
	typescript = { exec = "bun %" },
}

for lang, data in pairs(lang_maps) do
	if data.build ~= nil then
		vim.api.nvim_create_autocmd(
			"FileType",
			{
				command = "nnoremap <Leader>b :!" .. data.build .. "<CR>",
				pattern = lang,
			}
		)
	end

	vim.api.nvim_create_autocmd(
		"FileType",
		{
			command = "nnoremap <Leader>e :split<CR>:terminal "
				.. data.exec
				.. "<CR>",
			pattern = lang,
		}
	)
end

vim.api.nvim_create_autocmd(
	"InsertEnter",
	{ command = "set norelativenumber", pattern = "*" }
)
vim.api.nvim_create_autocmd(
	"InsertLeave",
	{ command = "set relativenumber", pattern = "*" }
)

vim.api.nvim_create_autocmd(
	"FileType",
	{ command = "set filetype=astro", pattern = "astro" }
)
vim.api.nvim_create_autocmd(
	"FileType",
	{
		command = "nnoremap <Leader>ub :!g++ % -g -o ~/dev/cp/main<CR>",
		pattern = "cpp",
	}
)
vim.api.nvim_create_autocmd(
	"FileType",
	{ command = "nnoremap <Leader>ue :!~/dev/cp/main<CR>", pattern = "cpp" }
)
vim.api.nvim_create_autocmd(
	"FileType",
	{ command = "set commentstring=//\\ %s", pattern = "c,cpp" }
)
vim.api.nvim_create_autocmd(
	"FileType",
	{ command = "set commentstring=#\\ %s", pattern = "nix" }
)
vim.api.nvim_create_autocmd(
	"FileType",
	{ command = "set expandtab", pattern = "nix" }
)
vim.api.nvim_create_autocmd(
	"FileType",
	{ command = "set filetype=cpp", pattern = "tpp" }
)
