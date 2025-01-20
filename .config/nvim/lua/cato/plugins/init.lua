return {
	"nvim-lua/popup.nvim",

	-- Allows quick switch from nvim to tmux splits
	{
		"alexghergh/nvim-tmux-navigation",
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
		config = true,
	},

	-- Additional language modes
	{ "digitaltoad/vim-pug", lazy = true, event = "BufEnter" },
	{ "pearofducks/ansible-vim", lazy = true, event = "BufEnter" },
	{ "hashivim/vim-terraform", lazy = true, event = "BufEnter" },
	{ "evanleck/vim-svelte", lazy = true, event = "BufEnter" },
	{ "prisma/vim-prisma", lazy = true, event = "BufEnter" },
	{ "rhysd/vim-syntax-codeowners", lazy = true, event = "BufEnter" },
	{
		"rhadley-recurly/vim-terragrunt",
		lazy = true,
		event = "BufEnter",
		config = function()
			vim.g.hcl_fmt_autosave = 0
		end,
	},
}
