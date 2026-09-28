return {
	"folke/which-key.nvim",
	dependencies = { "echasnovski/mini.icons", "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		vim.o.timeout = true
		vim.o.timeoutlen = 500

		-- General maps
		wk.add({
			{ "<leader>+", "<C-a>", desc = "Increment Number Under Cursor" },
			{ "<leader>-", "<C-x>", desc = "Decrement Number Under Cursor" },
			{ "<leader>nh", "<cmd>nohl<cr>", desc = "Hide search highlights", noremap = false },
			{ "<leader>]t", "<cmd>lua require('todo-comments').jump_next()", desc = "Next TODO Comment" },
			{ "<leader>[t", "<cmd>lua require('todo-comments').jump_prev()", desc = "Previous TODO Comment" },
			{ "<leader>wq", '<cmd>s/%V(.*)%V/"\1",/<cr>', desc = "Wrap selection in quotes", mode = "v" },
			{ "<D-l>", "<cmd>Lazy<cr>", desc = "Lazy 󰒲 " },
		})

		wk.add({
			{ "<leader>d", group = "Debugger " },
			{ "<leader>f", group = "Telescope " },
			{ "<leader>g", group = "Git Things " },
			{ "<leader>l", group = "LSP Actions " },
			{ "<leader>x", group = "Trouble 󰔫" },
		})

		wk.add({
			{ "<leader>t", group = "Tab Management 裡" },
			{ "<leader>tn", "<cmd>tabn<cr>", desc = "Move to Next Tab" },
			{ "<leader>tn", "<cmd>tabn<cr>", desc = "Move to Next Tab" },
			{ "<leader>to", "<cmd>tabnew<cr>", desc = "Open New Tab" },
			{ "<leader>tp", "<cmd>tabp<cr>", desc = "Move to Previous Tab" },
			{ "<leader>tx", "<cmd>tabclose<cr>", desc = "Close Current Tab" },
		})

		wk.add({
			{ "<leader>w", group = "Split Management " },
			{ "<leader>wn", "<C-w>=", desc = "Make Splits Equal" },
			{ "<leader>wn", "<C-w>s", desc = "Split Window Horizontally" },
			{ "<leader>wo", "<C-w>v", desc = "Split Window Vertically" },
			{ "<leader>wx", "<cmd>close<cr>", desc = "Close Current Split" },
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
