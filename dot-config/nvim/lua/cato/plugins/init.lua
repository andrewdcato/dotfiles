return {
	-- Allows quick switch from nvim to tmux splits
	{
		"alexghergh/nvim-tmux-navigation",
		event = "VeryLazy",
		config = function()
			require("nvim-tmux-navigation").setup({
				disable_when_zoomed = true, -- defaults to false
				keybindings = {
					left = "<C-h>",
					down = "<C-j>",
					up = "<C-k>",
					right = "<C-l>",
					last_active = "<C-\\>",
					next = "<C-Space>",
				},
			})
		end,
	},

	-- Quickly comment things out
	{
		"numToStr/Comment.nvim",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		event = "VeryLazy",
		config = function()
			-- NOTE: load this first and kill its autocommand...
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})

			require("Comment").setup({
				-- NOTE: run this hook so that Comment.nvim will work in JSX/TSX/Svelte files
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
}
