return {
	"stevearc/conform.nvim",
	event = "LspAttach",
	dependencies = { "neovim/nvim-lspconfig" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			rust = { "rustfmt", lsp_format = "fallback" },
			go = { "gofmt" },
			-- TODO: figure out why prettierd is fucked?
			javascript = { "eslint_d", "prettier", stop_after_first = true },
			typescript = { "prettier", stop_after_first = true },
			svelte = { "prettier", stop_after_first = true },
			terraform = { "terraform_fmt" },
			["_"] = { "prettier" },
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 1000,
		},
	},
}
