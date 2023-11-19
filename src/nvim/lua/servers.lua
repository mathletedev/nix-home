require("mason").setup {
	PATH = "append",
}

local servers = {
	"astro",
	"bashls",
	"clangd",
	"cssls",
	"eslint",
	"gopls",
	"html",
	"jedi_language_server",
	"lua_ls",
	"rnix",
	"svelte",
	"tailwindcss",
	"tsserver",
	"yamlls",
}

require("neodev").setup {
	override = function(root_dir, library)
		if root_dir:find(vim.fn.expand "$HOME/.config/home-manager/src/nvim", 1, true) == 1 then
			library.enabled = true
			library.plugins = true
		end
	end,
}

require("mason-lspconfig").setup {
	ensure_installed = servers,
	automatic_installation = true,
}

local lspconfig = require "lspconfig"
for _, server in pairs(servers) do
	local opts = {
		on_attach = function(_, bufnr)
			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
			local opts = { buffer = bufnr }

			vim.keymap.set("n", "<Leader>h", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<Leader>i", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action, opts)
		end,
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
	}

	if server == "lua_ls" then
		opts.settings = {
			Lua = {
				completion = { callSnippet = "Replace" },
				diagnostics = {
					disable = { "missing-fields" },
				},
				workspace = { checkThirdParty = false },
			},
		}
	end

	lspconfig[server].setup(opts)
end

require("rust-tools").setup {
	server = {
		standalone = false,
	},
	dap = {
		adapter = {
			id = "cppdbg",
			type = "executable",
			command = vim.fn.expand "$HOME/bin/OpenDebugAD7",
		},
	},
}

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

local ft = require "guard.filetype"
ft("python"):fmt "black"
ft("go"):fmt "gofmt"
ft("typescript,javascript,json,css,yaml,astro,svelte"):fmt "prettier"
ft("rust"):fmt "rustfmt"
ft("lua"):fmt "stylua"

require("guard").setup {
	fmt_on_save = true,
	lsp_as_default_formatter = true,
}

require("nvim-treesitter.configs").setup {
	ensure_installed = {
		"astro",
		"bash",
		"c",
		"cpp",
		"css",
		"dart",
		"go",
		"html",
		"java",
		"json",
		"lua",
		"make",
		"nix",
		"python",
		"rust",
		"sql",
		"svelte",
		"tsx",
		"typescript",
		"yaml",
	},
	highlight = { enable = true },
}

local dap = require "dap"
dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = vim.fn.expand "$HOME/bin/OpenDebugAD7",
}
local dap_config = {
	name = "Launch file",
	type = "cppdbg",
	request = "launch",
	program = function()
		local dir = "/"
		if vim.bo.filetype == "rust" then
			dir = "/target/debug/"
		end
		---@diagnostic disable-next-line
		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. dir, "file")
	end,
	cwd = "${workspaceFolder}",
	stopAtEntry = true,
}
dap.configurations.c = { dap_config }
dap.configurations.cpp = { dap_config }
dap.configurations.rust = { dap_config }

local dapui = require "dapui"
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.disconnect["dapui_config"] = function()
	dapui.close()
end
