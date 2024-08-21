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
			["<leader>]t"] = { "<cmd>lua require('todo-comments').jump_next()", "Next TODO Comment" },
			["<leader>[t"] = { "<cmd>lua require('todo-comments').jump_prev()", "Previous TODO Comment" },
			["<leader>wq"] = { '<cmd>s/%V(.*)%V/"\1",/<cr>', "Wrap selection in quotes", mode = "v" },
		})

		wk.register({
			["<leader>d"] = "Debugger ",
			["<leader>f"] = "Telescope ",
			["<leader>l"] = "LSP Actions ",
			["<leader>x"] = "Trouble 󰔫",
		})

		wk.register({
			["<leader>g"] = "Git Things ",
		})

		wk.register({
			["<D-l>"] = { "<cmd>Lazy<cr>", "Lazy 󰒲 " },
		})

		-- Window / Split Management
		wk.register({
			["<leader>t"] = {
				name = "Tab Management 裡",
				n = { "<cmd>tabn<cr>", "Move to Next Tab" },
				o = { "<cmd>tabnew<cr>", "Open New Tab" },
				p = { "<cmd>tabp<cr>", "Move to Previous Tab" },
				x = { "<cmd>tabclose<cr>", "Close Current Tab" },
			},
			["<leader>w"] = {
				name = "Window Management ",
				e = { "<C-w>=", "Make Splits Equal" },
				h = { "<C-w>s", "Split Window Horizontally" },
				v = { "<C-w>v", "Split Window Vertically" },
				x = { "<cmd>close<cr>", "Close Current Split" },
			},
		})

		wk.setup({
			win = {
				border = "double",
				-- winblend = 50,
				-- margin = { 0, 5, 3, 5 },
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
