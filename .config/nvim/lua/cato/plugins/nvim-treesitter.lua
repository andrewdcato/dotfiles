return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-tree-docs",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"windwp/nvim-ts-autotag",
		},
		config = function()
			local treesitter = require("nvim-treesitter.configs")

			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})

			treesitter.setup({
				auto_install = true,
				ensure_installed = {
					"bash",
					"css",
					"dockerfile",
					"go",
					"gomod",
					"gosum",
					"hcl",
					"html",
					"javascript",
					"jsdoc",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"prisma",
					"pug",
					"rust",
					"svelte",
					"terraform",
					"toml",
					"typescript",
					"vim",
					"yaml",
				},
				highlight = { enabled = true }, -- enable extension
				indentation = { enabled = true },
				rainbow = {
					enable = true,
					extended_mode = true,
					max_file_lines = nil,
				},
				sync_install = false, -- force async install
				tree_docs = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})

			require("nvim-ts-autotag").setup()
		end,
	},
}
