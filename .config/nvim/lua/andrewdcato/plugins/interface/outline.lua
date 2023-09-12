return {
	"simrat39/symbols-outline.nvim",
	keys = {
		{ "<leader>o", "<cmd>SymbolsOutline<cr>", desc = "Open Symbols Outline" },
	},
	config = function()
		local icons = require("andrewdcato.util").icons

		local icon_table = {}
		for symbol, icon in pairs(icons.kinds) do
			icon_table[symbol] = { icon = icon }
		end

		require("symbols-outline").setup({
			auto_preview = false,
			autofold_depth = 2,
			higlight_hovered_item = true,
			relative_width = true,
			show_symbol_details = true,
			symbols = icon_table,
			width = 15,
		})
	end,
}
