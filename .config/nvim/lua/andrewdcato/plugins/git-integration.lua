return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				numhl = true,
			})
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
			{ "<leader>gc", "<cmd>LazyGitConfig<cr>", desc = "Edit LazyGit Config" },
		},
		config = true,
	},
	{
		"akinsho/git-conflict.nvim",
		config = function()
			require("git-conflict").setup({
				default_commands = true,
				default_mappings = true,
				highlights = { incoming = "DiffText", current = "DiffAdd" },
			})
		end,
	},
}
