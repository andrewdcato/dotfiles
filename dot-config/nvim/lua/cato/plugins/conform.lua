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
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			svelte = { "prettierd", "prettier", stop_after_first = true },
			terraform = { "terraform_fmt" },
			toml = { "taplo" },
			["_"] = { "prettier" },
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 1000,
		},
	},
}
