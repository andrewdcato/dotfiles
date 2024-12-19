return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
	event = "VeryLazy",
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle float<cr>", silent = true, desc = "Float File Explorer" },
	},
	config = function()
		local neotree = require("neo-tree")
		local icons = require("cato.util").icons

		vim.fn.sign_define("DiagnosticSignError", { text = icons.diagnostics.error, texthl = "DiagnosticSignError" })
		vim.fn.sign_define("DiagnosticSignWarn", { text = icons.diagnostics.warn, texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define("DiagnosticSignInfo", { text = icons.diagnostics.info, texthl = "DiagnosticSignInfo" })
		vim.fn.sign_define("DiagnosticSignHint", { text = icons.diagnostics.hint, texthl = "DiagnosticSignHint" })

		neotree.setup({
			close_if_last_window = true,
			popup_border_style = "single",
			enable_git_status = true,
			enable_modified_markers = true,
			enable_diagnostics = true,
			default_component_configs = {
				modified = {
					symbol = " ",
					highlight = "NeoTreeModified",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
					folder_empty_open = "",
				},
				git_status = {
					symbols = {
						-- Change type
						added = icons.git.added,
						deleted = icons.git.deleted,
						modified = icons.git.modified,
						renamed = icons.git.renamed,
						-- Status type
						untracked = icons.git.untracked,
						ignored = icons.git.ignored,
						unstaged = icons.git.unstaged,
						staged = icons.git.staged,
						conflict = icons.git.conflict,
					},
				},
			},
			sort_case_insensitive = true,
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = true,
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
			window = {
				position = "float",
				width = 35,
				mappings = {
					["<C-x>"] = "open_split",
					["<C-v>"] = "open_vsplit",
				},
			},
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = true,
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
			event_handlers = {
				{
					event = "neo_tree_window_after_open",
					handler = function(args)
						if args.position == "left" or args.position == "right" then
							vim.cmd("wincmd =")
						end
					end,
				},
				{
					event = "neo_tree_window_after_close",
					handler = function(args)
						if args.position == "left" or args.position == "right" then
							vim.cmd("wincmd =")
						end
					end,
				},
			},
		})
	end,
}
