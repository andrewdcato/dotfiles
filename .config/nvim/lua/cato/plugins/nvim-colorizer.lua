return {
	"norcalli/nvim-colorizer.lua",
	event = "LspAttach",
	dependencies = { "roobert/tailwindcss-colorizer-cmp.nvim" },
	config = function()
		require("colorizer").setup({
			"css",
			"lua",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"tailwind",
		})
	end,
}
