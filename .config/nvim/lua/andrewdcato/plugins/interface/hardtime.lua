return {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	opts = {
		disable_mouse = false,
		disabled_filetypes = {
			"dapui",
			"mason",
			"neo-tree",
			"Outline",
			"TelescopePrompt",
			"lazy",
			"spectre_panel",
		},
	},
}
