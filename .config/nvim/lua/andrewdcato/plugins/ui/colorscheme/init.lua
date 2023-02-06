require("andrewdcato.plugins.ui.colorscheme.treesitter")
require("andrewdcato.plugins.ui.colorscheme.colors.nord")

local illuminate_ok, illuminate = pcall(require, "illuminate")
if not illuminate_ok then
	return
end

illuminate.configure({
	filetypes_denylist = {
		"NvimTree",
		"alpha",
		"packer",
		"lspsagaoutline",
	},
})
