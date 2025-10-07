return {
	"mvllow/modes.nvim",
	dependencies = { "catppuccin/nvim" },
	event = "VeryLazy",
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
			-- TODO: ignore in snacks pickers
			ignore = { "neo-tree", "TelescopePrompt" },
		})
	end,
}
