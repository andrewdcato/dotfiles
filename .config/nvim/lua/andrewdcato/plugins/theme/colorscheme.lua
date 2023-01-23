-- Gruvbox config
-- local gruvbox_installed, gruvbox = pcall(require, "gruvbox")
-- if not gruvbox_installed then
-- 	return
-- end
--
-- gruvbox.setup({
-- 	inverse = true,
-- 	contrast = "hard",
-- 	transparent_mode = true,
-- })
--
-- cmd([[colorscheme gruvbox]])

-- nightfox config
local installed, nightfox = pcall(require, "nightfox")
if not installed then
	return
end

nightfox.setup({
	options = {
		transparent = true,
		styes = {
			strings = "italic,bold",
			comments = "italic",
		},
	},
})

vim.cmd("colorscheme nightfox")
