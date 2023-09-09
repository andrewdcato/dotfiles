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
	{ "numToStr/Comment.nvim", config = true },

	-- Additional language modes
	"digitaltoad/vim-pug",
	"pearofducks/ansible-vim",
	"hashivim/vim-terraform",
	"evanleck/vim-svelte",
	"prisma/vim-prisma",
}
