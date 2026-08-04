return {
	"lervag/vimtex",
	-- WARN: don't let this be lazy-loaded per vimtex docs
	lazy = false,
	init = function()
		vim.g.vimtex_view_method = "zathura"
	end,
}
