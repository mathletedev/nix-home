return {
	{
		"zbirenbaum/copilot-cmp",
		dependencies = {
			{
				"zbirenbaum/copilot.lua",
				cmd = "Copilot",
				event = "InsertEnter",
				opts = {
					suggestion = { enabled = false },
					panel = { enabled = false },
				},
			},
		},
		opts = {},
	},
}
