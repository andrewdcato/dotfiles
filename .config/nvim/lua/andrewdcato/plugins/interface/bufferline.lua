local icons = require("andrewdcato.util").icons

return {
	{
		"akinsho/bufferline.nvim",
		dependencies = { "catppuccin/nvim" },
		config = function()
			local highlights = require("catppuccin.groups.integrations.bufferline").get()

			require("bufferline").setup({
				highlights = highlights,
				options = {
					indicator = { style = "underline" },
					diagnostics = "nvim_lsp",
					offsets = {
						{
							filetype = "neo-tree",
							text = "File Explorer",
							text_align = "center",
							separator = true,
						},
						{
							filetype = "NvimTree",
							text = "File Explorer",
							text_align = "center",
							separator = true,
						},
						{
							filetype = "lspsagaoutline",
							text = "Outline",
							text_align = "center",
							separator = true,
						},
						{
							filetype = "Outline",
							text = "Outline",
							text_align = "center",
							separator = true,
						},
					},
					separator_style = "thin",
				},
			})
		end,
	},
	{
		"utilyre/barbecue.nvim",
		dependencies = { "catppuccin/nvim" },
		config = function()
			require("barbecue").setup({
				theme = "catppuccin",
				symbols = {
					modified = icons.git.modified,
				},
				kinds = icons.kinds,
			})
		end,
	},
}
