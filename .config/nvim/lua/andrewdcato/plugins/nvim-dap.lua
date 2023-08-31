local jsdebugger_installed, dap_vscode_js = pcall(require, "dap-vscode-js")
if not jsdebugger_installed then
	return
end

local dap_installed, dap = pcall(require, "dap")
if not dap_installed then
	return
end

local dap_ui_installed, dap_ui = pcall(require, "dapui")
if not dap_ui_installed then
	return
end

dap_vscode_js.setup({
	debugger_path = "/Users/andrewcato/.local/share/nvim/site/pack/packer/opt/vscode-js-debug",
	adapters = { "pwa-node", "pwa-chrome" }, -- which adapters to register in nvim-dap
})

dap_ui.setup({
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
			-- size = (vim.api.nvim_win_get_height(0) * 0.25),
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
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "DapLogPoint" })

-- TODO: get this properly set up w/latest version of vscode-js-debug
-- require("dap.ext.vscode").load_launchjs(nil, { ["pwa-node"] = { "javascript", "typescript" } })

for _, language in ipairs({ "typescript", "javascript" }) do
	-- ignore external modules and node.js guts when stepping through code
	local skipFiles = {
		"${workspaceFolder}/<node_internals>/**",
		"${workspaceFolder}/node_modules/**",
	}

	dap.configurations[language] = {
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
