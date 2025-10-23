local function get_pkg_path(pkg, path)
	pcall(require, "mason") -- make sure Mason is loaded. Will fail when generating docs

	local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")

	path = path or ""

	return root .. "/packages/" .. pkg .. "/" .. path
end

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			{
				"microsoft/vscode-js-debug",
				build = "npm i --no-package-lock && npm run compile vsDebugServerBundle && rm -rf out && mv -f dist out",
			},
			{
				-- NOTE: needed to support loading debug configs from ./.vscode/launch.json files, as those contain comments and
				--        aren't valid JSON
				"Joakker/lua-json5",
				build = "./install.sh",
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
		},
		config = function()
			-- Set highlights and icons for breakpoints
			vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
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
			local dap = require("dap")
			local dapui = require("dapui")
			require("nvim-dap-virtual-text").setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({})
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close({})
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close({})
			end

			if not dap.adapters["pwa-node"] then
				dap.adapters["pwa-node"] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "node",
						args = {
							get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
							"${port}",
						},
					},
				}
			end

			if not dap.adapters["node"] then
				dap.adapters["node"] = function(cb, config)
					if config.type == "node" then
						config.type = "pwa-node"
					end
					local nativeAdapter = dap.adapters["pwa-node"]
					if type(nativeAdapter) == "function" then
						nativeAdapter(cb, config)
					else
						cb(nativeAdapter)
					end
				end
			end

			-- setup dap config by VsCode launch.json file
			local vscode = require("dap.ext.vscode")
			local json = require("plenary.json")
			vscode.json_decode = function(str)
				return vim.json.decode(json.json_strip_comments(str))
			end

			-- dap.adapters["pwa-node"] = {
			-- 	type = "server",
			-- 	host = "localhost",
			-- 	port = "${port}",
			-- 	executable = {
			-- 		command = "node",
			-- 		args = { vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/dist/src/extension.js", "${port}" },
			-- 	},
			-- }
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		keys = {
			{ "<leader>dt", "<cmd>lua require('dapui').toggle()<cr>", desc = " Debugger: Toggle DapUI Window " },
			{
				"<leader>de",
				function()
					require("dapui").eval()
				end,
				desc = " Debugger: Eval",
				mode = { "n", "v" },
			},
		},
		config = function()
			-- NOTE: FIXES LOADING JSON5
			-- https://github.com/neovim/neovim/issues/21749#issuecomment-1378720864
			table.insert(vim._so_trails, "/?.dylib")

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
						size = 40,
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
		end,
	},
}
