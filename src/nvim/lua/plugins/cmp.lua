return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"onsails/lspkind.nvim",
			"saadparwaiz1/cmp_luasnip",
			"zbirenbaum/copilot.lua",
		},
		config = function()
			local cmp = require "cmp"
			local ls = require "luasnip"
			local lspkind = require "lspkind"

			require("luasnip/loaders/from_snipmate").lazy_load {
				paths = { "~/.config/home-manager/src/nvim/snippets" },
			}

			cmp.setup {
				sources = {
					{ name = "copilot" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				},
				mapping = cmp.mapping.preset.insert {
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-k>"] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					},
					["<C-n>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif ls.expand_or_jumpable() then
							ls.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-p>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif ls.jumpable(-1) then
							ls.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				formatting = {
					format = lspkind.cmp_format {
						mode = "symbol",
						symbol_map = {
							Copilot = "",
						},
					},
				},
				snippet = {
					expand = function(args)
						ls.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
			}
		end,
	},
}
