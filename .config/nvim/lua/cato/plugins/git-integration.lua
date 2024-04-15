return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				numhl = true,
				current_line_blame = true,
			})

			vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview git hunk" })
			vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle line blame" })
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
			{ "<leader>gc", "<cmd>LazyGitConfig<cr>", desc = "Edit LazyGit Config" },
		},
		config = function()
			vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
			vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window

			vim.g.lazygit_use_custom_config_file_path = 1 -- config file path is evaluated if this value is 1
			vim.g.lazygit_config_file_path = os.getenv("HOME") .. "/.config/lazygit/config.yml" -- custom config file path
		end,
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
	{
		"tpope/vim-fugitive",
		-- config = function() end,
	},
}
