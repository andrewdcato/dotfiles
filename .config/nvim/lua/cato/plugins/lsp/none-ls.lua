local ft = {
	prettier = {
		"css",
		"graphql",
		"html",
		"javascript",
		"javascript.jsx",
		"javascriptreact",
		"json",
		"less",
		"markdown",
		"scss",
		"svelte",
		"typescript.tsx",
		"typescriptreact",
		"typescript",
		"yaml",
	},
	eslint = {
		"javascript",
		"javascript.jsx",
		"javascriptreact",
		"svelte",
		"typescript.tsx",
		"typescriptreact",
		"typescript",
	},
}

return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "j-hui/fidget.nvim", "nvimtools/none-ls-extras.nvim" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local null_ls = require("null-ls")
		local null_ls_utils = require("null-ls.utils")

		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			debug = false,
			root_dir = null_ls_utils.root_pattern(".git", "package.json"),
			sources = {
				diagnostics.ansiblelint,
				formatting.prettierd.with({
					filetypes = ft.prettier,
					condition = function(utils)
						return utils.root_has_file({ ".prettierrc", "prettier.config.js", ".prettierignore" })
					end,
				}),
				formatting.stylua,
				formatting.terraform_fmt,
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 2000 })
						end,
					})
				end
			end,
		})
	end,
}
