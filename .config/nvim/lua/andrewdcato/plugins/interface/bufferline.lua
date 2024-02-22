return {
	{
		"akinsho/bufferline.nvim",
		dependencies = { "catppuccin/nvim" },
		config = function()
			require("bufferline").setup({
				highlights = require("catppuccin.groups.integrations.bufferline").get(),
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
			local icons = require("andrewdcato.util").icons

			require("barbecue").setup({
				theme = "catppuccin",
				modified = function(bufnr)
					return vim.bo[bufnr].modified
				end,
				show_modified = true,
				symbols = {
					modified = icons.git.modified,
				},
				kinds = icons.kinds,
			})
		end,
	},
}
