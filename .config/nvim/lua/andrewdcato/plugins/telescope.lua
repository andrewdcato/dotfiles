local extensions = {
	"fzf",
	"file_browser",
	"notify",
}

local pickers = {
	find_files = {
		hidden = true,
	},
}

local layout_config = {
	prompt_position = "top",
	width = 0.85,
	height = 0.85,
}

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-dap.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"LinArcX/telescope-env.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				extensions,
				pickers,
				defaults = {
					layout_config = layout_config,
					color_devicons = true,
					mappings = {
						i = {
							["<C-n>"] = actions.cycle_history_next,
							["<C-p>"] = actions.cycle_history_prev,

							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,

							["<C-c>"] = actions.close,

							["<CR>"] = actions.select_default,
							["<C-x>"] = actions.select_horizontal,
							["<C-v>"] = actions.select_vertical,
							["<C-t>"] = actions.select_tab,

							["<C-u>"] = actions.preview_scrolling_up,
							["<C-d>"] = actions.preview_scrolling_down,

							["<PageUp>"] = actions.results_scrolling_up,
							["<PageDown>"] = actions.results_scrolling_down,

							["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
							["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
							["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
							["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<C-l>"] = actions.complete_tag,
							["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
						},
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("file_browser")
			telescope.load_extension("notify")
			-- telescope.load_extension("dap")
			telescope.load_extension("env")

			local km = vim.keymap

			km.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "﬘ Search Open Buffers" })
			km.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = " Search Current Word" })
			km.set("n", "<leader>fe", "<cmd>Telescope env<cr>", { desc = "󱃻 View Current Environment Variables" })
			km.set(
				"n",
				"<leader>ff",
				"<cmd>Telescope find_files hidden=true<cr>",
				{ desc = " Search Current Directory" }
			)
			km.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = " Search Git Files" })
			km.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = " Search 'Help' Tags" })
			km.set("n", "<leader>fn", "<cmd>Telescope notify<cr>", { desc = " Search Notifications" })
			km.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = " Open Recent Files" })
			km.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = " Live Grep Search" })
			km.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = " View TODO comments" })
		end,
	},
}
