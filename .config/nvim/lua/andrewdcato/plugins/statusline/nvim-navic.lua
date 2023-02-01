local navic_installed, navic = pcall(require, "nvim-navic")
if not navic_installed then
	return
end

-- Set highlight groups
-- NORD colors pulled from: https://www.nordtheme.com/docs/colors-and-palettes
vim.api.nvim_set_hl(0, "NavicIconsFile", { default = false, bg = "#3B4252", fg = "#BF616A" })
vim.api.nvim_set_hl(0, "NavicIconsModule", { default = false, bg = "#3B4252", fg = "#D08770" })
vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = false, bg = "#3B4252", fg = "#EBCB8B" })
vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = false, bg = "#3B4252", fg = "#D08770" })
vim.api.nvim_set_hl(0, "NavicIconsClass", { default = false, bg = "#3B4252", fg = "#5E81AC" })
vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = false, bg = "#3B4252", fg = "#A3BE8C" })
vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = false, bg = "#3B4252", fg = "#BF616A" })
vim.api.nvim_set_hl(0, "NavicIconsField", { default = false, bg = "#3B4252", fg = "#A3BE8C" })
vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = false, bg = "#3B4252", fg = "#B48EAD" })
vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = false, bg = "#3B4252", fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = false, bg = "#3B4252", fg = "#5E81AC" })
vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = false, bg = "#3B4252", fg = "#88C0D0" })
vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = false, bg = "#3B4252", fg = "#EBCB8B" })
vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = false, bg = "#3B4252", fg = "#D08770" })
vim.api.nvim_set_hl(0, "NavicIconsString", { default = false, bg = "#3B4252", fg = "#A3BE8C" })
vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = false, bg = "#3B4252", fg = "#D08770" })
vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = false, bg = "#3B4252", fg = "#81A1C1" })
vim.api.nvim_set_hl(0, "NavicIconsArray", { default = false, bg = "#3B4252", fg = "#88C0D0" })
vim.api.nvim_set_hl(0, "NavicIconsObject", { default = false, bg = "#3B4252", fg = "#EBCB8B" })
vim.api.nvim_set_hl(0, "NavicIconsKey", { default = false, bg = "#3B4252", fg = "#A3BE8C" })
vim.api.nvim_set_hl(0, "NavicIconsNull", { default = false, bg = "#3B4252", fg = "#BF616A" })
vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = false, bg = "#3B4252", fg = "#5E81AC" })
vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = false, bg = "#3B4252", fg = "#8FBCBB" })
vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = false, bg = "#3B4252", fg = "#EBCB9B" })
vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = false, bg = "#3B4252", fg = "#B48EAD" })
vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = false, bg = "#3B4252", fg = "#8FBCBB" })
vim.api.nvim_set_hl(0, "NavicText", { default = false, bg = "#3B4252", fg = "#eceff4" })
vim.api.nvim_set_hl(0, "NavicSeparator", { default = false, bg = "#3B4252", fg = "#eceff4" })

local kind_icons = {
	File = " ", -- red
	Module = " ", -- orange
	Namespace = " ", -- yellow
	Package = " ", -- orange
	Class = " ", -- frost 4
	Method = "m ", -- green
	Property = " ", -- red
	Field = " ", -- green
	Constructor = " ", -- purple
	Enum = " ", -- frost 3
	Interface = " ", -- frost 4
	Function = " ", -- frost 2
	Variable = " ", -- yellow
	Constant = " ", -- orange
	String = " ", -- green
	Number = " ", -- orange
	Boolean = " ", -- frost 3
	Array = " ", -- frost 2
	Object = " ", -- yellow
	Key = " ", -- green
	Null = "ﳠ ", -- red
	EnumMember = " ", -- frost 4
	Struct = " ", -- frost 1
	Event = " ", -- yellow
	Operator = " ", -- purple
	TypeParameter = " ", -- frost 1
}

navic.setup({
	icons = kind_icons,
	highlight = true,
	safe_output = true,
	separator = "  ",
})

return navic
