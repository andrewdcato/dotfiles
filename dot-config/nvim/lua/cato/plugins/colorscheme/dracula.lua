return {
	"Mofiqul/dracula.nvim",
	enabled = false,
	lazy = false,
	priority = 1000,
	config = function()
		require("dracula").setup({
			show_end_of_buffer = true,
			transparent_bg = true,
		})

		vim.cmd([[colorscheme dracula]])
	end,
}
