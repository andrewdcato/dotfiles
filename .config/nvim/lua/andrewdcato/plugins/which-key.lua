return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		vim.o.timeout = true
		vim.o.timeoutlen = 500

		-- General maps
		wk.register({
			["<leader>+"] = { "<C-a>", "Increment Number Under Cursor" },
			["<leader>-"] = { "<C-x>", "Decrement Number Under Cursor" },
			["<leader>nh"] = { "<cmd>nohl<cr>", "Hide search highlights", noremap = false },
			["<leader>t"] = { "<cmd>Neotree toggle<cr>", "Open File Tree", noremap = false },
			["<leader>o"] = { "<cmd>SymbolsOutline<cr>", "Open Outline", noremap = false },
			["<leader>]t"] = { "<cmd>lua require('todo-comments').jump_next()", "Next TODO Comment" },
			["<leader>[t"] = { "<cmd>lua require('todo-comments').jump_prev()", "Previous TODO Comment" },
		})

		-- Debugger keymaps
		wk.register({
			["<F5>"] = { "<cmd>lua require('dap').continue()<cr>", " Debugger: Continue " },
			["<F6>"] = { "<cmd>lua require('dap').step_over()<cr>", " Debugger: Step Over " },
			["<F7>"] = { "<cmd>lua require('dap').step_into()<cr>", " Debugger: Step Into " },
			["<F8>"] = { "<cmd>lua require('dap').step_out()<cr>", " Debugger: Step Out " },
			["b"] = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", " Debugger: Toggle Breakpoint " },
			["<leader>dt"] = { "<cmd>lua require('dapui').toggle()<cr>", " Debugger: Toggle DapUI Window " },
		})

		-- Telescope keymaps
		wk.register({
			["<leader>f"] = {
				name = "Telescope ",
			},
		})

		-- Git keymaps
		wk.register({
			["<leader>g"] = {
				name = "Git Things ",
			},
		})

		-- LSP Config
		wk.register({
			["<leader>l"] = {
				name = "LSP Actions ",
			},
		})

		-- Window / Split Management
		wk.register({
			["<leader>s"] = {
				name = "Window Splits ",
				e = { "<C-w>=", "Make Splits Equal" },
				h = { "<C-w>s", "Split Window Horizontally" },
				v = { "<C-w>v", "Split Window Vertically" },
				x = { "<cmd>close<cr>", "Close Current Split" },
			},
			["<leader>t"] = {
				name = "Tab Management 裡",
				n = { "<cmd>tabn<cr>", "Move to Next Tab" },
				o = { "<cmd>tabnew<cr>", "Open New Tab" },
				p = { "<cmd>tabp<cr>", "Move to Previous Tab" },
				x = { "<cmd>tabclose<cr>", "Close Current Tab" },
			},
		})

		wk.setup({
			window = {
				border = "single",
				winblend = 0,
				margin = { 0, 5, 3, 5 },
				padding = { 1, 1, 1, 1 },
			},
			layout = {
				align = "center",
				spacing = 5,
			},
			disable = {
				filetypes = { "TelescopePrompt" },
			},
		})
	end,
}
