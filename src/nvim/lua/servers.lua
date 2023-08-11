local ls = require "luasnip"

local cmp = require "cmp"
cmp.setup {
	snippet = {
		expand = function(args)
			ls.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert {
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif ls.expand_or_jumpable() then
				ls.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif ls.jumpable(-1) then
				ls.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = { { name = "nvim_lsp" }, { name = "luasnip" } },
}

require("luasnip.loaders.from_snipmate").lazy_load { paths = "~/.config/home-manager/src/nvim/snippets" }

local null_ls = require "null-ls"
null_ls.setup {
	sources = {
		null_ls.builtins.diagnostics.eslint_d.with { extra_filetypes = { "astro", "svelte" } },
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.eslint_d.with { extra_filetypes = { "astro", "svelte" } },
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.prettier.with { extra_filetypes = { "astro", "svelte" } },
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
		"c",
		"cpp",
		"css",
		"go",
		"html",
		"java",
		"json",
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

require("mason").setup {
	PATH = "append",
}

local servers = {
	"astro",
	"bashls",
	"clangd",
	"cssls",
	"gopls",
	"html",
	"jedi_language_server",
	"lua_ls",
	"rnix",
	"rust_analyzer",
	"svelte",
	"tailwindcss",
	"tsserver",
	"yamlls",
}

local deny_formatting = {
	"astro",
	"gopls",
	"html",
	"rust_analyzer",
	"lua_ls",
	"jedi_language_server",
	"svelte",
	"tsserver",
	"yamlls",
}

require("mason-lspconfig").setup {
	ensure_installed = servers,
	automatic_installation = true,
}

local lsp_formatting = function(bufnr)
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

for _, server in pairs(servers) do
	local opts = {
		on_attach = function(_, bufnr)
			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
			local opts = { buffer = bufnr }

			vim.keymap.set("n", "<Leader>h", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<Leader>i", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, opts)

			local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = false })

			vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end,
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
	}

	if server == "lua_ls" then
		opts.settings = { Lua = { diagnostics = { globals = { "vim" } } } }
	end

	lspconfig[server].setup(opts)
end
