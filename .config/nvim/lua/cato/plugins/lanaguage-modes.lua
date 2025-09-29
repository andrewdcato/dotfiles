-- NOTE: set up languages that nvim doesn't support out-of-the-box

return {
	{ "digitaltoad/vim-pug", lazy = true, event = "BufEnter" },
	{ "pearofducks/ansible-vim", lazy = true, event = "BufEnter" },
	{ "hashivim/vim-terraform", lazy = true, event = "BufEnter" },
	{ "evanleck/vim-svelte", lazy = true, event = "BufEnter" },
	{ "prisma/vim-prisma", lazy = true, event = "BufEnter" },
	{ "rhysd/vim-syntax-codeowners", lazy = true, event = "BufEnter" },
	{
		"rhadley-recurly/vim-terragrunt",
		lazy = true,
		event = "BufEnter",
		config = function()
			vim.g.hcl_fmt_autosave = 0
		end,
	},
}
