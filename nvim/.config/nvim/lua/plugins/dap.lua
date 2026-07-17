return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
			},
			{
				"<leader>b",
				function()
					require("dap").toggle_breakpoint()
				end,
			},
			{
				"<leader>B",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.open()
				end,
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
			},
		},
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		keys = {
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
			},
			{
				"<leader>dh",
				function()
					require("dapui").eval()
				end,
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			local mason = vim.fn.stdpath("data") .. "/mason"
			local codelldb = mason .. "/bin/codelldb"

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = codelldb,
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.rust = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			dap.configurations.c = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			dap.configurations.cpp = dap.configurations.c
		end,
	},
}
