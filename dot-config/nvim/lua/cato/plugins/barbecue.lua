return {
	"utilyre/barbecue.nvim",
	event = "LspAttach",
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
}
