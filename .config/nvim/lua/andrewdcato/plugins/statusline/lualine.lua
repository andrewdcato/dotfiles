local installed, lualine = pcall(require, "lualine")
if not installed then
	return
end

local navic = require("andrewdcato.plugins.statusline.nvim-navic")

local branch_component = { "b:gitsigns_head", icon = "" }

local diff_component = {
	"diff",
	source = function()
		local gitsigns = vim.b.gitsigns_status_dict
		if gitsigns then
			return {
				added = gitsigns.added,
				modified = gitsigns.modified,
				removed = gitsigns.removed,
			}
		end
	end,
	symbols = { added = " ", modified = " ", removed = " " },
}

local navic_component = {
	"filename",
	{
		navic.get_location,
		cond = navic.is_available,
		padding = { left = 1, right = 0 },
	},
}

local disabled_filetypes = {
	statusline = { "alpha", "lspsagaoutline" },
	winbar = { "alpha", "lspsagaoutline" },
}

vim.opt.laststatus = 3

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "nord",
		component_separators = { left = "", right = "" },
		section_separators = { right = " ", left = " " },
		disabled_filetypes = disabled_filetypes,
	},
	sections = {
		lualine_a = {
			{
				"mode",
				icon = "",
			},
		},
		lualine_b = {
			branch_component,
			diff_component,
			"diagnostics",
		},
		lualine_c = navic_component,
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	extensions = {
		"nvim-dap-ui",
		"nvim-tree",
	},
})
