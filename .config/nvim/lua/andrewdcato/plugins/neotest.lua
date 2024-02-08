return {
	"nvim-neotest/neotest",
	dependencies = {
		"antoinemadec/FixCursorHold.nvim",
		"marilari88/neotest-vitest",
		"nvim-lua/plenary.nvim",
		"nvim-neotest/neotest-jest",
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{ "<leader>nt", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Neotest: Toggle Summary Sidebar" },
		{
			"<leader>nf",
			"<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
			desc = "Neotest: Run Current File",
		},
		{ "<leader>nw", "<cmd>lua require('neotest').watch.watch()<cr>", desc = "Neotest: Watch" },
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-jest"),
				require("neotest-vitest"),
			},
			output = {
				enabled = true,
				open_on_run = true,
			},
			status = {
				enabled = true,
				signs = true,
				virtual_text = true,
			},
		})
	end,
}
