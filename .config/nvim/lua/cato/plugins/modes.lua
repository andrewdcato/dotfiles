return {
	"mvllow/modes.nvim",
	dependencies = { "catppuccin/nvim" },
	config = function()
		local colors = require("catppuccin.palettes").get_palette("mocha")

		require("modes").setup({
			colors = {
				copy = colors.orange,
				delete = colors.red,
				insert = colors.green,
				visual = colors.maroon,
			},
			line_opacity = 0.35,
			set_cursor = true,
			set_cursorline = true,
			set_number = true,
			ignore_filetypes = { "neo-tree", "TelescopePrompt" },
		})
	end,
}
