return {
	"lervag/vimtex",
	-- WARN: don't let this be lazy-loaded per vimtex docs
	lazy = false,
	init = function()
		vim.g.vimtex_view_method = "skim"
		vim.g.vimtex_view_skim_sync = 1 -- Enable forward search after compilation
		vim.g.vimtex_view_skim_activate = 1 -- Change focus to Skim on viewer launch
	end,
}
