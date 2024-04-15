return {
	"mvllow/modes.nvim",
	dependencies = { "catppuccin/nvim" },
	config = function()
		local colors = require("catppuccin.palettes").get_palette()

		require("modes").setup({
			colors = {
				copy = colors.peach,
				delete = colors.red,
				insert = colors.green,
				visual = colors.lavender,
			},
			-- Set opacity for cursorline and number background
			line_opacity = 0.35,
			-- Enable cursor highlights
			set_cursor = true,
			-- Enable cursorline initially, and disable cursorline for inactive windows
			-- or ignored filetypes
			set_cursorline = true,
			-- Enable line number highlights to match cursorline
			set_number = true,
			-- Disable modes highlights in specified filetypes
			-- Please PR commonly ignored filetypes
			ignore_filetypes = { "neo-tree", "TelescopePrompt", "lspsagaoutline" },
		})
	end,
}
