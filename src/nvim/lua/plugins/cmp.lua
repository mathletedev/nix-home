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

			require("luasnip/loaders/from_snipmate").lazy_load { paths = { "~/.config/home-manager/src/nvim/snippets" } }

			cmp.setup {
				formatting = {
					format = lspkind.cmp_format {},
				},
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
						elseif require("copilot.suggestion").is_visible() then
							require("copilot.suggestion").accept()
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
		end,
	},
}
