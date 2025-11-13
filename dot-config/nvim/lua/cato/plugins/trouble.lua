return {
	"folke/trouble.nvim",
	dependencies = { "neovim/nvim-lspconfig" },
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle focus=false<cr>",
			desc = "Trouble: Toggle Document Diagnostics",
		},
		{
			"<leader>xd",
			"<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>",
			desc = "Trouble: Toggle Document Diagnostics",
		},
		{ "<leader>xq", "<cmd>Trouble toggle quickfix<cr>", desc = "Trouble: Toggle Quickfix List" },
		{ "<leader>xl", "<cmd>Trouble toggle lsp_references<cr>", desc = "Trouble: Toggle LSP References" },
		{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Trouble: View TODO Comments" },
	},
	opts = {
		use_diagnostic_signs = true,
		auto_close = true,
		auto_open = false,
	},
}
