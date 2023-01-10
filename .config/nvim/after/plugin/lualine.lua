local installed, lualine = pcall(require, "lualine")
if not installed then
	return
end

lualine.setup {
	options = {
		icons_enabled = true,
		theme = 'gruvbox',
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename'},
		lualine_d = {'encoding', 'fileformat'},
		lualine_e = {'filetype'},
		lualine_f = {'location'},
	},
	tabline = {
		lualine_a = {'buffers'},
		lualine_b = {'tabs'},
		lualine_c = {},
		lualine_d = {},
		lualine_e = {},
		lualine_f = {},
	},
	extensions = {'nvim-tree'},
}
