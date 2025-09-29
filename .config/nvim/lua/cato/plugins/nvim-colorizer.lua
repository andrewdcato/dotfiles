return {
	"norcalli/nvim-colorizer.lua",
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
