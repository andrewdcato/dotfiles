local treesitter_installed, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_installed then
	return
end

return treesitter.setup({
	ensure_installed = { -- list of parsers to install
		"bash",
		"css",
		"dockerfile",
		"html",
		"javascript",
		"json",
		"jsdoc",
		"lua",
		"markdown",
		"typescript",
		"vim",
		"yaml",
	},
	sync_install = false, -- force async install
	highlight = { endable = true }, -- enable extension
})
