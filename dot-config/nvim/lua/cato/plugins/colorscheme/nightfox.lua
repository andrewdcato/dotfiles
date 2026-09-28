return {
	"EdenEast/nightfox.nvim",
	enabled = false,
	priority = 1000,
	lazy = false,
	config = function()
		local palette = require("nightfox.palette").load("nordfox")

		require("nightfox").setup({
			options = {
				transparent = true,
				styles = {
					comments = "italic",
				},
				groups = {
					-- Neotree
					NeoTreeNormal = { bg = palette.bg0 },
					NeoTreeNormalNc = { bg = palette.bg0 },
					NeoTreeTabActive = { bg = palette.bg0, fg = palette.blue.bright },
					NeoTreeTabSeparatorActive = { bg = palette.bg0, fg = palette.bg0 },
					NeoTreeTabInactive = { bg = palette.bg1, fg = palette.magenta.base },
					NeoTreeTabSeparatorInactive = { bg = palette.bg1, fg = palette.bg1 },
				},
				modules = {
					neotree = { enabled = true },
				},
			},
		})

		-- TODO: figure out how to assign colors here
		vim.cmd([[
        autocmd ColorScheme * highlight NormalFloat guibg=NONE ctermbg=NONE
        autocmd ColorScheme * highlight Float guibg=NONE ctermbg=NONE
        autocmd ColorScheme * highlight FloatBorder guibg=NONE ctermbg=NONE
        autocmd ColorScheme * highlight FloatShadow guibg=NONE ctermbg=NONE
      ]])

		vim.cmd([[colorscheme nordfox]])
	end,
}
