return {
	{
		"saghen/blink.compat",
		version = "*",
		lazy = true,
		opts = {},
	},
	{
		"saghen/blink.cmp",
		version = "*",
		dependencies = {
			"saghen/blink.compat",
			"rafamadriz/friendly-snippets",
			"xzbdmw/colorful-menu.nvim",
			"bydlw98/cmp-env",
		},
		opts = {
			keymap = {
				preset = "super-tab",
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
			},
			fuzzy = {
				implementation = "rust",
				frecency = { enabled = true },
				prebuilt_binaries = {
					download = true,
					ignore_version_mismatch = false,
				},
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			-- default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "dadbod", "markdown", "env" },
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
					markdown = {
						name = "RenderMarkdown",
						module = "render-markdown.integ.blink",
						fallbacks = { "lsp" },
					},
					env = {
						name = "env",
						module = "blink.compat.source",
						opts = {
							show_braces = false,
							show_documentation_window = true,
						},
					},
				},
			},
			signature = { enabled = true },
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = {
						border = "rounded",
					},
				},
				menu = {
					border = "rounded",
					draw = {
						columns = {
							{ "kind_icon", "kind", gap = 1 },
							{ "label", gap = 1 },
							{ "source_name", "source_id", gap = 1 },
						},
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},
			},
		},
		-- allows extending the providers array elsewhere in your config
		-- without having to redefine it
		opts_extend = { "sources.default" },
	},
}
