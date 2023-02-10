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
