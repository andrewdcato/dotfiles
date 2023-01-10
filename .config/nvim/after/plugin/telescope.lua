local telescope_installed, telescope = pcall(require, "telescope")
if not telescope_installed then
	return
end

local actions_configured, actions = pcall(require, "telescope.actions")
if not actions_configured then
	return
end

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
			}
		}
	}
})

telescope.load_extension("fzf")
