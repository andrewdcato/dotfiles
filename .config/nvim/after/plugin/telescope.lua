local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
	return
end

local actions_ok, actions = pcall(require, "telescope.actions")
if not actions_ok then
	return
end

local extensions = {
	"fzf",
	"file_browser",
	"packer",
	"notify",
}

local pickers = {
	find_files = {
		hidden = true,
	},
}

telescope.setup({
	extensions,
	pickers,
	defaults = {
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
telescope.load_extension("packer")
telescope.load_extension("notify")
