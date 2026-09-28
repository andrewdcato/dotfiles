return {
	"norcalli/nvim-colorizer.lua",
	event = "LspAttach",
	dependencies = { "roobert/tailwindcss-colorizer-cmp.nvim" },
	opts = {
		"css",
		"lua",
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"tailwind",
	},
}
