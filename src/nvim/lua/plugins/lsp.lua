return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"j-hui/fidget.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		},
		config = function()
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

			require("mason-lspconfig").setup {
				ensure_installed = servers,
				automatic_installation = true,
			}

			require("neodev").setup {
				override = function(root_dir, library)
					if root_dir:find(vim.fn.expand "$HOME/.config/home-manager/src/nvim", 1, true) == 1 then
						library.enabled = true
						library.plugins = true
					end
				end,
			}

			require("fidget").setup {}

			vim.diagnostic.config { virtual_text = false }
			require("lsp_lines").setup()
			vim.keymap.set("n", "<Leader>x", require("lsp_lines").toggle)

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
					handlers = {
						["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
						["textDocument/signatureHelp"] = vim.lsp.with(
							vim.lsp.handlers.signature_help,
							{ border = "rounded" }
						),
					},
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

				require("lspconfig")[server].setup(opts)
			end

			vim.fn.sign_define("DiagnosticSignError", { text = "●", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = "●", texthl = "DiagnosticSignWarn" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = "●", texthl = "DiagnosticSignInfo" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "●", texthl = "DiagnosticSignHint" })
		end,
	},
}
