local icons = require("andrewdcato.util").icons
-- local bufferline_ok, bufferline = pcall(require, "bufferline")
-- if bufferline_ok then
-- 	local highlights = require("catppuccin.groups.integrations.bufferline").get()
--
-- 	bufferline.setup({
-- 		highlights = highlights,
-- 		options = {
-- 			indicator = { style = "underline" },
-- 			diagnostics = "nvim_lsp",
-- 			offsets = {
-- 				{
-- 					filetype = "neo-tree",
-- 					separator = true,
-- 				},
-- 				{
-- 					filetype = "NvimTree",
-- 					text = "File Explorer",
-- 					text_align = "center",
-- 					separator = true,
-- 				},
-- 				{
-- 					filetype = "lspsagaoutline",
-- 					text = "Outline",
-- 					text_align = "center",
-- 					separator = true,
-- 				},
-- 				{
-- 					filetype = "Outline",
-- 					text = "Outline",
-- 					text_align = "center",
-- 					separator = true,
-- 				},
-- 			},
-- 			separator_style = "thin",
-- 		},
-- 	})
-- end

local barbecue_ok, barbecue = pcall(require, "barbecue")
if barbecue_ok then
	barbecue.setup({
		theme = "catppuccin",
		symbols = {
			modified = icons.git.modified,
		},
		kinds = icons.kinds,
	})
end
