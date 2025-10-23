return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		local custom_higlights = function(colors)
			return {
				-- General overrides
				NotifyBackground = { bg = "#000000" },
				TabLine = { bg = colors.mantle, fg = colors.text },
				-- git-conflict
				DiffText = { bg = colors.surface1, fg = colors.mantle },
				DiffAdd = { bg = colors.surface0, fg = colors.mantle },
				-- header and footer of feline
				UserTLHead = { bg = colors.blue, fg = colors.mantle },
				UserTlHeadSep = { bg = colors.mantle, fg = colors.blue },
				-- active tab
				UserTLActive = { bg = colors.sky, fg = colors.mantle },
				UserTlActiveSepL = { bg = colors.sky, fg = colors.mantle },
				UserTlActiveSepR = { bg = colors.mantle, fg = colors.sky },
				-- inactive tab
				UserTLInactive = { bg = colors.surface1, fg = colors.crust },
				UserTLInactiveSepL = { bg = colors.surface1, fg = colors.mantle },
				UserTLInactiveSepR = { bg = colors.mantle, fg = colors.surface1 },
				-- active window
				UserTLTopWin = { bg = colors.sapphire, fg = colors.mantle },
				UserTLTopWinL = { bg = colors.sapphire, fg = colors.mantle },
				UserTLTopWinR = { bg = colors.mantle, fg = colors.sapphire },
				-- inactive window(s)
				UserTLWin = { bg = colors.surface1, fg = colors.sapphire },
				UserTLWinL = { bg = colors.surface1, fg = colors.mantle },
				UserTLWinR = { bg = colors.mantle, fg = colors.surface1 },
				-- Neotree
				NeoTreeNormal = { bg = colors.mantle },
				NeoTreeNormalNc = { bg = colors.mantle },
				NeoTreeTabActive = { bg = colors.mantle, fg = colors.sapphire },
				NeoTreeTabSeparatorActive = { bg = colors.mantle, fg = colors.mantle },
				NeoTreeTabInactive = { bg = colors.base, fg = colors.lavender },
				NeoTreeTabSeparatorInactive = { bg = colors.base, fg = colors.base },
				-- Debugger
				DapBreakpoint = { bg = colors.mantle, fg = colors.sapphire },
			}
		end

		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, mocha, mocha
			background = {
				light = "latte",
				dark = "mocha",
			},
			transparent_background = true,
			float = {
				transparent = true, -- enable transparent floating windows
				solid = false, -- use solid styling for floating windows, see |winborder|
			},
			show_end_of_buffer = true, -- show the '~' characters after the end of buffers
			term_colors = true,
			dim_inactive = {
				enabled = false,
				shade = "dark",
				percentage = 0.15,
			},
			no_italic = false, -- Force no italic
			no_bold = false, -- Force no bold
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				loops = {},
				functions = { "italic" },
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = { "italic" },
				properties = {},
				types = {},
				operators = {},
			},
			color_overrides = {},
			custom_highlights = custom_higlights,
			default_integrations = false,
			auto_integrations = true,

			integrations = {
				barbecue = {
					dim_dirname = true, -- directory name is dimmed by default
					bold_basename = true,
					dim_context = false,
					alt_background = false,
				},
				dap = {
					enabled = true,
					enable_ui = true,
				},
				indent_blankline = {
					enabled = true,
					scope_color = "sky",
					colored_indent_levels = false,
				},
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
						ok = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
						ok = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
				snacks = {
					enabled = true,
					indent_scope_color = "sky",
				},
			},
		})

		vim.cmd([[colorscheme catppuccin]])
	end,
}
