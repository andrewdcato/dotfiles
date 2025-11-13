vim.opt.updatetime = 2000

vim.api.nvim_create_autocmd("CursorHold", {
	buffer = bufnr,
	callback = function()
		local opts = {
			focusable = false,
			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			border = "rounded",
			source = "always",
			prefix = " ",
			scope = "cursor",
		}
		vim.diagnostic.open_float(nil, opts)
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "MasonUpdateAllComplete",
	callback = function()
		vim.notify("mason-update-all has updated all language servers!", "info", { title = "Mason Plugins" })
	end,
})

-- Set YAML files to ansible filetype
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
	pattern = "*/playbooks/{*.yml,*.yaml}",
	command = "set filetype=yaml.ansible",
})

-- Terraform filetypes
vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
	pattern = "*/{*.tf,*.tfvars, terragrunt.hcl}",
	command = "set filetype=terraform",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
	pattern = "*/{*.hcl,.terraformrc,terraform.rc}",
	command = "set filetype=hcl",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
	pattern = "**/*.postcss",
	command = "set filetype=css",
})

-- Reload Aerospace config on save
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = vim.fn.expand("$XDG_CONFIG_HOME") .. "/aerospace/*",
	callback = function()
		vim.fn.system("aerospace reload-config")
		vim.notify("Aerospace config reloaded", "info", { title = "Aerospace" })
	end,
})

-- Reload tmux config on save
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = vim.fn.expand("$XDG_CONFIG_HOME") .. "/tmux/*",
	callback = function()
		vim.fn.system("tmux source-file ~/.config/tmux/tmux.conf")
		vim.notify("Tmux config reloaded", "info", { title = "Tmux" })
	end,
})

-- Reload sketchybar config on save
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = vim.fn.expand("$XDG_CONFIG_HOME") .. "/sketchybar/*",
	callback = function()
		vim.fn.system("sketchybar --reload")
		vim.notify("Sketchybar config reloaded", "info", { title = "Sketchybar" })
	end,
})
