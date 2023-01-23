local installed, lualine = pcall(require, "lualine")
if not installed then
	return
end

local navic_installed, navic = pcall(require, "nvim-navic")
if not navic_installed then
	return
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = {
			left = "",
			right = "",
		},
		section_separators = {
			right = " ",
			left = " ",
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename", { navic.get_location, cond = navic.is_available } },
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
