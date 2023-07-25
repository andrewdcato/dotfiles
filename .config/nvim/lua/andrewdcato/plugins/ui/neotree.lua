local neotree_ok, neotree = pcall(require, "neo-tree")
if not neotree_ok then
	return
end

local icons = require("andrewdcato.util").icons

vim.fn.sign_define("DiagnosticSignError", { text = icons.diagnostics.error, texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = icons.diagnostics.warn, texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = icons.diagnostics.info, texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = icons.diagnostics.hint, texthl = "DiagnosticSignHint" })

return neotree.setup({
	close_if_last_window = true,
	enable_git_status = true,
	enable_diagnostics = true,
	filesystem = {
		filtered_items = {
			visible = false,
			hide_dotfiles = false,
			hide_gitignored = false,
			always_show = {
				".gitignore",
				".env",
			},
			never_show = {
				".git",
				".DS_store",
				"thumbs.db",
			},
		},
	},
	source_selector = {
		winbar = true,
		sources = {
			{ source = "filesystem", display_name = "  Files " },
			{ source = "buffers", display_name = "  Buffers " },
			{ source = "git_status", display_name = "  Git " },
		},
	},
})
