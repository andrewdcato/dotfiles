return {
	"folke/trouble.nvim",
	dependencies = { "neovim/nvim-lspconfig" },
	keys = {
		{ "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Trouble: Toggle Main Window" },
		{
			"<leader>xw",
			"<cmd>TroubleToggle workspace_diagnostics<cr>",
			desc = "Trouble: Toggle Workspace Diagnostics",
		},
		{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble: Toggle Document Diagnostics" },
		{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble: Toggle Quickfix List" },
		{ "<leader>xl", "<cmd>TroubleToggle lsp_references<cr>", desc = "Trouble: Toggle LSP References" },
		{ "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Trouble: Toggle LocList" },
		{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Trouble: View TODO Comments" },
	},
	config = function()
		require("trouble").setup({
			use_diagnostic_signs = true,
			auto_close = true,
			auto_open = true,
		})
	end,
}
