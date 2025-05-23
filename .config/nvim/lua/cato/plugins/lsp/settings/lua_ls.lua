return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "bufnr", "Snacks" },
			},
		},
		workspace = {
			library = {
				[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.stdpath("config") .. "/lua"] = true,
			},
		},
	},
}
