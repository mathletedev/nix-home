local luasnip = require "luasnip"

local cmp = require "cmp"
cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert {
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = { { name = "nvim_lsp" }, { name = "luasnip" } },
}

local null_ls = require "null-ls"
null_ls.setup {
	sources = {
		null_ls.builtins.diagnostics.eslint_d.with { extra_filetypes = { "astro", "svelte" } },
		null_ls.builtins.formatting.autopep8,
		null_ls.builtins.formatting.eslint_d.with { extra_filetypes = { "astro", "svelte" } },
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.stylish_haskell,
	},
}

local lspconfig = require "lspconfig"

require("nvim-treesitter.configs").setup {
	ensure_installed = {
		"astro",
		"bash",
		"cpp",
		"css",
		"go",
		"html",
		"java",
		"lua",
		"make",
		"nix",
		"python",
		"rust",
		"svelte",
		"tsx",
		"typescript",
		"yaml",
	},
	highlight = { enable = true },
}

require("rust-tools").setup {}

require("mason").setup {}

local servers = {
	"astro",
	"bashls",
	"clangd",
	"cssls",
	"gopls",
	"html",
	"pyright",
	"rnix",
	"rust_analyzer",
	"sumneko_lua",
	"svelte",
	"tailwindcss",
	"tsserver",
}

require("mason-lspconfig").setup {
	ensure_installed = servers,
	automatic_installation = true,
}

local lsp_formatting = function(bufnr)
	local deny_formatting = { "astro", "gopls", "html", "rust_analyzer", "sumneko_lua", "svelte", "tsserver" }
	vim.lsp.buf.format {
		filter = function(client)
			for _, value in pairs(deny_formatting) do
				if client.name == value then
					return false
				end
			end
			return true
		end,
		bufnr = bufnr,
		timeout_ms = 4000,
	}
end

local opts = {
	on_attach = function(client, bufnr)
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
		local opts = { buffer = bufnr }

		vim.keymap.set("n", "<Leader>h", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<Leader>i", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, opts)

		local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = false })

		if client.supports_method "textDocument/formatting" then
			vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
}

for _, server in pairs(servers) do
	if server == "sumneko_lua" then
		opts.settings = { Lua = { diagnostics = { globals = { "vim" } } } }
	end

	lspconfig[server].setup(opts)
end
