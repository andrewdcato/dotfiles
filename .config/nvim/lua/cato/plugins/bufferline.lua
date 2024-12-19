return {
	{
		"akinsho/bufferline.nvim",
		dependencies = { "catppuccin/nvim" },
		enabled = false,
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
		after = "nvim-web-devicons",
		config = function()
			local icons = require("cato.util").icons

			require("barbecue").setup({
				theme = "auto",
				context_follow_icon_color = true,
				show_dirname = true,
				show_basename = true,
				show_modified = true,
				modifiers = {
					dirname = ":~:.",
					basename = ":s/+//:s/page.svelte/FRONTEND/:s/page.server.ts/BACKEND/:t:r",
				},
				modified = function(bufnr)
					return vim.bo[bufnr].modified
				end,
				symbols = {
					modified = icons.git.modified,
				},
				kinds = icons.kinds,
			})
		end,
	},
}
