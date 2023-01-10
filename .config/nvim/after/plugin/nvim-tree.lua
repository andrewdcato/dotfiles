local nvim_tree_installed, nvimtree = pcall(require, "nvim-tree")
if not nvim_tree_installed then
	return
end

-- Settings per docs
vim.g.loaded_netrw = 1
vim.g.laoded_netrwPlugin = 1

return nvimtree.setup({
	filters = { dotfiles = false },		-- show hidden files
	sort_by = 'name',
	view = { adaptive_size = true },
	actions = {
		open_file = {
			window_picker = {
				enable = false
			}
		}
	}
})
