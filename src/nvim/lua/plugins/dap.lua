return {
	{
		"mfussenegger/nvim-dap",
		event = "BufWinEnter",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require "dap"

			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "-i", "dap" },
			}

			local dap_config = {
				name = "Launch",
				type = "gdb",
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
				stopAtBeginningOfMainSubprogram = false,
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

			require("nvim-dap-virtual-text").setup {}

			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignInfo" })
			vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticSignHint" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticSignInfo" })
			vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticSignOk" })

			vim.keymap.set("n", "<Leader>d", require("dap").continue)
			vim.keymap.set("n", "<Leader>s", require("dap").toggle_breakpoint)
			vim.keymap.set("n", "<Leader>w", function()
				require("dap").terminate()
				require("dapui").close()
			end)
		end,
	},
}
