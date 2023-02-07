local navic_installed, navic = pcall(require, "nvim-navic")
if not navic_installed then
	return
end

local icons = require("andrewdcato.util").icons.kinds

-- -- Set highlight groups
-- -- NORD colors pulled from: https://www.nordtheme.com/docs/colors-and-palettes
-- vim.api.nvim_set_hl(0, "NavicIconsFile", { default = false, bg = "#3B4252", fg = "#BF616A" })
-- vim.api.nvim_set_hl(0, "NavicIconsModule", { default = false, bg = "#3B4252", fg = "#D08770" })
-- vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = false, bg = "#3B4252", fg = "#EBCB8B" })
-- vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = false, bg = "#3B4252", fg = "#D08770" })
-- vim.api.nvim_set_hl(0, "NavicIconsClass", { default = false, bg = "#3B4252", fg = "#5E81AC" })
-- vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = false, bg = "#3B4252", fg = "#A3BE8C" })
-- vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = false, bg = "#3B4252", fg = "#BF616A" })
-- vim.api.nvim_set_hl(0, "NavicIconsField", { default = false, bg = "#3B4252", fg = "#A3BE8C" })
-- vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = false, bg = "#3B4252", fg = "#B48EAD" })
-- vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = false, bg = "#3B4252", fg = "#81A1C1" })
-- vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = false, bg = "#3B4252", fg = "#5E81AC" })
-- vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = false, bg = "#3B4252", fg = "#88C0D0" })
-- vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = false, bg = "#3B4252", fg = "#EBCB8B" })
-- vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = false, bg = "#3B4252", fg = "#D08770" })
-- vim.api.nvim_set_hl(0, "NavicIconsString", { default = false, bg = "#3B4252", fg = "#A3BE8C" })
-- vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = false, bg = "#3B4252", fg = "#D08770" })
-- vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = false, bg = "#3B4252", fg = "#81A1C1" })
-- vim.api.nvim_set_hl(0, "NavicIconsArray", { default = false, bg = "#3B4252", fg = "#88C0D0" })
-- vim.api.nvim_set_hl(0, "NavicIconsObject", { default = false, bg = "#3B4252", fg = "#EBCB8B" })
-- vim.api.nvim_set_hl(0, "NavicIconsKey", { default = false, bg = "#3B4252", fg = "#A3BE8C" })
-- vim.api.nvim_set_hl(0, "NavicIconsNull", { default = false, bg = "#3B4252", fg = "#BF616A" })
-- vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = false, bg = "#3B4252", fg = "#5E81AC" })
-- vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = false, bg = "#3B4252", fg = "#8FBCBB" })
-- vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = false, bg = "#3B4252", fg = "#EBCB9B" })
-- vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = false, bg = "#3B4252", fg = "#B48EAD" })
-- vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = false, bg = "#3B4252", fg = "#8FBCBB" })
-- vim.api.nvim_set_hl(0, "NavicText", { default = false, bg = "#3B4252", fg = "#eceff4" })
-- vim.api.nvim_set_hl(0, "NavicSeparator", { default = false, bg = "#3B4252", fg = "#eceff4" })

navic.setup({
	icons = icons,
	highlight = true,
	safe_output = true,
	separator = "  ",
})
