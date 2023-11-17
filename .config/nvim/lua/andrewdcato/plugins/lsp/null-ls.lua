return {
	"jose-elias-alvarez/null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local null_ls = require("null-ls")
		local null_ls_utils = require("null-ls.utils")

		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			debug = false,
			root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
			sources = {
				formatting.prettier.with({
					filetypes = {
						"css",
						"graphql",
						"html",
						"javascript.jsx",
						"javascriptreact",
						"json",
						"less",
						"markdown",
						"scss",
						"svelte",
						"typescript.tsx",
						"typescriptreact",
						"yaml",
					},
				}),
				formatting.eslint_d.with({
					filetypes = {
						"javascript",
						"typescript",
					},
				}),
				formatting.stylua,
				formatting.prismaFmt,
				formatting.terraform_fmt,
				diagnostics.eslint_d.with({
					condition = function(utils)
						return utils.root_has_file({ ".eslintrc", ".eslintrc.js", ".eslintrc.cjs" })
					end,
				}),
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
