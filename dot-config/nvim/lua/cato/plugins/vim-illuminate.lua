return {
	"RRethy/vim-illuminate",
	config = function()
		require("illuminate").configure({
			filetypes_denylist = {
				"neo-tree",
				"alpha",
				"lspsagaoutline",
			},
		})
	end,
}
