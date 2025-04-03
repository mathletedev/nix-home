return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("neodev").setup {
				override = function(root_dir, library)
					if
						root_dir:find(
							vim.fn.expand "$HOME/.config/home-manager/src/nvim",
							1,
							true
						) == 1
					then
						library.enabled = true
						library.plugins = true
					end
				end,
			}

			require("mason").setup {
				PATH = "append",
			}

			local lspconfig = require "lspconfig"
			local lsp = require("core.common").lsp

			require("mason-lspconfig").setup {
				automatic_installation = true,
				ensure_installed = {
					"astro",
					"bashls",
					"clangd",
					"clojure_lsp",
					"cssls",
					"elixirls",
					"gopls",
					"html",
					"lua_ls",
					"mdx_analyzer",
					"nextls",
					-- "ocamllsp",
					"pyright",
					"rnix",
					"svelte",
					"tailwindcss",
					"texlab",
					"ts_ls",
					"verible",
					"yamlls",
				},
				handlers = {
					function(server)
						lspconfig[server].setup {
							on_attach = lsp.on_attach,
							capabilities = lsp.capabilities,
							handlers = lsp.handlers,
						}
					end,
					["clangd"] = function()
						local alt_capabilities =
							require("cmp_nvim_lsp").default_capabilities()
						alt_capabilities.offsetEncoding = { "utf-16" }

						lspconfig.clangd.setup {
							on_attach = lsp.on_attach,
							capabilities = lsp.capabilities,
							handlers = lsp.handlers,
						}
					end,
					["lua_ls"] = function()
						lspconfig.lua_ls.setup {
							on_attach = lsp.on_attach,
							capabilities = lsp.capabilities,
							handlers = lsp.handlers,
							settings = {
								Lua = {
									completion = { callSnippet = "Replace" },
									diagnostics = {
										disable = { "missing-fields" },
									},
									workspace = { checkThirdParty = false },
								},
							},
						}
					end,
				},
			}

			lspconfig.gleam.setup {
				on_attach = lsp.on_attach,
				capabilities = lsp.capabilities,
				handlers = lsp.handlers,
			}

			lspconfig.gdscript.setup {
				on_attach = lsp.on_attach,
				capabilities = lsp.capabilities,
				handlers = lsp.handlers,
			}

			vim.diagnostic.config {
				virtual_text = false,
				virtual_lines = {
					only_current_line = true,
				},
			}

			vim.fn.sign_define(
				"DiagnosticSignError",
				{ text = "●", texthl = "DiagnosticSignError" }
			)
			vim.fn.sign_define(
				"DiagnosticSignWarn",
				{ text = "●", texthl = "DiagnosticSignWarn" }
			)
			vim.fn.sign_define(
				"DiagnosticSignInfo",
				{ text = "●", texthl = "DiagnosticSignInfo" }
			)
			vim.fn.sign_define(
				"DiagnosticSignHint",
				{ text = "●", texthl = "DiagnosticSignHint" }
			)
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("lspsaga").setup {
				code_action = {
					keys = { quit = "<Esc>" },
				},
				finder = {
					keys = {
						quit = "<Esc>",
						toggle_or_open = "<CR>",
					},
				},
				lightbulb = { enable = false },
				rename = {
					keys = { quit = "<Esc>" },
				},
			}
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		opts = {
			bind = true,
			handler_opts = {
				border = "rounded",
			},
		},
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		opts = {},
	},
}
