local nvim_tree_installed, nvimtree = pcall(require, "nvim-tree")
if not nvim_tree_installed then
	return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

-- Settings per docs
vim.g.loaded_netrw = 1
vim.g.laoded_netrwPlugin = 1

return nvimtree.setup({
	filters = { dotfiles = false },		-- show hidden files
	update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  sort_by = 'name',
	view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "v", cb = tree_cb "vsplit" },
      },
    }
  },
	git = { ignore = false },					-- show .gitignore-ed files	
 	diagnostics = {
    enable = true, show_on_dirs = false, show_on_open_dirs = true,
  },
  actions = {
		open_file = {
			window_picker = {
				enable = false
			}
		}
	}
})
