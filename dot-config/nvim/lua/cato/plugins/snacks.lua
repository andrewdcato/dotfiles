local dashboard = require("cato.plugins.snacks.dashboard")
local pickers = require("cato.plugins.snacks.pickers")

local exclude = {
	".git",
	".DS_Store",
	".terraform.lock.hcl",
}

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = vim.tbl_extend("force", pickers, {}),
	opts = {
		bigfile = { enabled = true },
		dashboard = dashboard,
		indent = { enabled = true },
		input = { enabled = true },
		lazygit = { enabled = false },
		notifier = { enabled = true },
		notify = { enabled = true },
		picker = {
			enabled = true,
			sources = {
				explorer = {
					hidden = true,
					ignored = true,
					exclude = vim.tbl_extend("force", exclude, {}),
				},
				files = {
					hidden = true,
					exclude = vim.tbl_extend("force", exclude, {}),
				},
			},
		},
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = false },
		words = { enabled = true },
	},
}
