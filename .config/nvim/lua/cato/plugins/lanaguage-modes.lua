-- NOTE: set up languages that nvim doesn't support out-of-the-box

return {
	{ "digitaltoad/vim-pug", lazy = true, event = "BufEnter *.pug" },
	{ "pearofducks/ansible-vim", lazy = true, event = "VeryLazy" },
	{ "hashivim/vim-terraform", lazy = true, event = "BufEnter *tf" },
	{ "evanleck/vim-svelte", lazy = true, event = "BufEnter *.svelte" },
	{ "prisma/vim-prisma", lazy = true, event = "BufEnter *.prisma" },
	{ "rhysd/vim-syntax-codeowners", lazy = true, event = "BufEnter CODEOWNERS, BufEnter codeowners" },
	{
		"rhadley-recurly/vim-terragrunt",
		lazy = true,
		event = "BufEnter *.hcl, BufEnter *.tf",
		config = function()
			vim.g.hcl_fmt_autosave = 0
		end,
	},
}
