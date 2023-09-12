return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"mxsdev/nvim-dap-vscode-js",
			"theHamsta/nvim-dap-virtual-text",
			{
				"microsoft/vscode-js-debug",
				run = "npm install --legacy-peer-deps && npm run compile",
				tag = "v1.74.1", -- you *must* specify this tag; newer versions have breaking bugs
			},
		},
		keys = {
			{ "<F5>", "<cmd>lua require('dap').continue()<cr>", desc = " Debugger: Continue " },
			{ "<F6>", "<cmd>lua require('dap').step_over()<cr>", desc = " Debugger: Step Over " },
			{ "<F7>", "<cmd>lua require('dap').step_into()<cr>", desc = " Debugger: Step Into " },
			{ "<F8>", "<cmd>lua require('dap').step_out()<cr>", desc = " Debugger: Step Out " },
			{
				"<leader>db",
				"<cmd>lua require('dap').toggle_breakpoint()<cr>",
				desc = " Debugger: Toggle Breakpoint ",
			},
			{ "<leader>dt", "<cmd>lua require('dapui').toggle()<cr>", desc = " Debugger: Toggle DapUI Window " },
		},
		config = function()
			require("dap-vscode-js").setup({
				debugger_path = "/Users/andrewcato/.local/share/nvim/lazy/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome" }, -- which adapters to register in nvim-dap
			})

			require("dapui").setup({
				controls = {
					element = "repl",
					enabled = true,
					icons = {
						disconnect = "",
						pause = "",
						play = "",
						run_last = "",
						step_back = "",
						step_into = "",
						step_out = "",
						step_over = "",
						terminate = "",
					},
				},
				element_mappings = {},
				expand_lines = true,
				floating = {
					border = "single",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				force_buffers = true,
				icons = {
					collapsed = "",
					current_frame = "",
					expanded = "",
				},
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						position = "left",
						size = (vim.api.nvim_win_get_width(0) * 0.35),
					},
					{
						elements = {
							{ id = "repl", size = 0.6 },
							{ id = "console", size = 0.4 },
						},
						position = "bottom",
						size = 25,
					},
				},
				mappings = {
					edit = "e",
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					repl = "r",
					toggle = "t",
				},
				render = {
					indent = 1,
					max_value_lines = 100,
				},
			})

			-- Set highlights and icons for breakpoints
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "", texthl = "DapBreakpointCondition", linehl = "", numhl = "DapBreakpointCondition" }
			)
			vim.fn.sign_define(
				"DapLogPoint",
				{ text = "", texthl = "DapLogPoint", linehl = "", numhl = "DapLogPoint" }
			)

			-- TODO: get this properly set up w/latest version of vscode-js-debug
			-- require("dap.ext.vscode").load_launchjs(nil, { ["pwa-node"] = { "javascript", "typescript" } })

			for _, language in ipairs({ "typescript", "javascript" }) do
				-- ignore external modules and node.js guts when stepping through code
				local skipFiles = {
					"${workspaceFolder}/<node_internals>/**",
					"${workspaceFolder}/node_modules/**",
				}

				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Monorepo: Debug AMS",
						cwd = "${workspaceFolder}",
						skipFiles = skipFiles,
						runtimeExecutable = "pnpm",
						restart = true,
						runtimeArgs = {
							"run-script",
							"start:ams-dev",
						},
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Monorepo: Debug LMS",
						cwd = "${workspaceFolder}",
						skipFiles = skipFiles,
						runtimeExecutable = "pnpm",
						restart = true,
						runtimeArgs = {
							"run-script",
							"start:lms-dev",
						},
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach to Process",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
						skipFiles = skipFiles,
					},
				}
			end
		end,
	},
}
