local outline_ok, outline = pcall(require, "symbols-outline")
if not outline_ok then
	return
end

local utils_ok, utils = pcall(require, "andrewdcato.util")
if not utils_ok then
	return
end

local icon_table = {}
for symbol, icon in pairs(utils.icons.kinds) do
	icon_table[symbol] = { icon = icon }
end

outline.setup({
	auto_preview = false,
	autofold_depth = 2,
	higlight_hovered_item = true,
	relative_width = true,
	show_symbol_details = true,
	symbols = icon_table,
	width = 15,
})
