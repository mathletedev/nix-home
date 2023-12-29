return {
	{
		"glepnir/dashboard-nvim",
		opts = {
			config = {
				header = {
					" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
					" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
					" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
					" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
					" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
					" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
					"                                                       ",
				},
				shortcut = {
					{
						icon = "󰝒 ",
						desc = "New File ",
						group = "DashboardHeader",
						action = "enew",
						key = "o",
					},
					{
						icon = " ",
						desc = "Find Files ",
						group = "DashboardHeader",
						action = "Telescope find_files",
						key = "f",
					},
					{
						icon = " ",
						desc = "Settings ",
						group = "DashboardHeader",
						action = "edit ~/.config/home-manager/src/nvim",
						key = "v",
					},
					{
						icon = "󰞈 ",
						desc = "Update ",
						group = "DashboardHeader",
						action = "PackerSync",
						key = "u",
					},
				},
			},
		},
	},
}
