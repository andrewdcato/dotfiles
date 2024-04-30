return {
	{ -- NOTE: needed to support loading debug configs from ./.vscode/launch.json files, as those contain comments and
		--        aren't valid JSON
		"Joakker/lua-json5",
		build = "./install.sh",
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"mxsdev/nvim-dap-vscode-js",
			"theHamsta/nvim-dap-virtual-text",
			{
				"microsoft/vscode-js-debug",
				-- HACK: checking out the package lock was added to get around errors when checking for updates
				build = "npm install --legacy-peer-deps && npm run compile && git checkout package-lock.json",
				tag = "v1.74.0", -- you *must* specify this tag; newer versions have breaking bugs
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
			-- NOTE: FIXES LOADING JSON5
			-- https://github.com/neovim/neovim/issues/21749#issuecomment-1378720864
			table.insert(vim._so_trails, "/?.dylib")

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

			-- Auto open / close dapui when debugger sessions start / end
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({})
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close({})
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close({})
			end

			local js_based_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
			require("dap.ext.vscode").load_launchjs(nil, {
				["pwa-node"] = js_based_languages,
				["node"] = js_based_languages,
				["chrome"] = js_based_languages,
				["pwa-chrome"] = js_based_languages,
			})
		end,
	},
}
