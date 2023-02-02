local installed, wk = pcall(require, "which-key")
if not installed then
	return
end

wk.register({
	f = {
		name = "File",
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent Files", noremap = false },
	},
}, { prefix = "<leader>" })

wk.setup({
	window = {
		winblend = 10,
	},
	layout = {
		align = "center",
		spacing = 5,
	},
	disable = {
		filetypes = { "TelescopePrompt" },
	},
})
