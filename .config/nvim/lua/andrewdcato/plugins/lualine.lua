local installed, lualine = pcall(require, "lualine")
if not installed then
	return
end

local navic_installed, navic = pcall(require, "nvim-navic")
if not navic_installed then
	return
end

local kind_icons = {
	File = " ",
	Module = " ",
	Namespace = " ",
	Package = " ",
	Class = " ",
	Method = "m ",
	Property = " ",
	Field = " ",
	Constructor = " ",
	Enum = " ",
	Interface = " ",
	Function = " ",
	Variable = " ",
	Constant = " ",
	String = " ",
	Number = " ",
	Boolean = " ",
	Array = " ",
	Object = " ",
	Key = " ",
	Null = "ﳠ ",
	EnumMember = " ",
	Struct = " ",
	Event = " ",
	Operator = " ",
	TypeParameter = " ",
}

navic.setup({
	icons = kind_icons,
	highlight = true,
	safe_output = true,
	separator = "  ",
})

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

local branch_component = { "b:gitsigns_head", icon = "" }

local diff_component = {
	"diff",
	source = diff_source,
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

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { right = " ", left = " " },
		disabled_filetypes = disabled_filetypes,
	},
	sections = {
		lualine_a = { "mode" },
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
