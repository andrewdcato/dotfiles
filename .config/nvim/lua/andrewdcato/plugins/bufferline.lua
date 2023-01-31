local bufferline_ok, bufferline = pcall(require, "bufferline")
if not bufferline_ok then
	return
end

local highlights = require("nord").bufferline.highlights({
	italic = false,
	bold = true,
})

bufferline.setup({
	options = {
		indicator = { style = "underline" },
		diagnostics = "nvim_lsp",
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "center",
				separator = true,
			},
			{
				filetype = "lspsagaoutline",
				text = "Outline",
				text_align = "center",
				separator = true,
			},
		},
		separator_style = "thick",
	},
	highlights = highlights,
})
