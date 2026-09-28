return {
	-- Allows quick switch from nvim to tmux splits
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},

	{
		"aimdevlee/herdr-nvim-nav",
		dependencies = { "christoomey/vim-tmux-navigator" }, -- omit if with_tmux = false
		config = function()
			require("herdr-nvim-nav").setup({
				with_tmux = nil, -- nil = auto-detect $TMUX; true/false to force
				keymaps = { -- lhs list per direction; {} disables a direction
					left = { "<C-h>", "<C-Left>" },
					down = { "<C-j>", "<C-Down>" },
					up = { "<C-k>", "<C-Up>" },
					right = { "<C-l>", "<C-Right>" },
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
