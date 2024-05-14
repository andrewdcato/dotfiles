return {
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		config = function()
			local palette = require("nightfox.palette").load("nordfox")

			require("nightfox").setup({
				options = {
					transparent = true,
					styles = {
						comments = "italic",
					},
					groups = {
						-- Neotree
						NeoTreeNormal = { bg = palette.bg0 },
						NeoTreeNormalNc = { bg = palette.bg0 },
						NeoTreeTabActive = { bg = palette.bg0, fg = palette.blue.bright },
						NeoTreeTabSeparatorActive = { bg = palette.bg0, fg = palette.bg0 },
						NeoTreeTabInactive = { bg = palette.bg1, fg = palette.magenta.base },
						NeoTreeTabSeparatorInactive = { bg = palette.bg1, fg = palette.bg1 },
					},
					modules = {
						neotree = { enabled = true },
					},
				},
			})

			-- TODO: figure out how to assign colors here
			vim.cmd([[
        autocmd ColorScheme * highlight NormalFloat guibg=NONE ctermbg=NONE
        autocmd ColorScheme * highlight Float guibg=NONE ctermbg=NONE
        autocmd ColorScheme * highlight FloatBorder guibg=NONE ctermbg=NONE
        autocmd ColorScheme * highlight FloatShadow guibg=NONE ctermbg=NONE
      ]])

			vim.cmd([[colorscheme nordfox]])
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		enabled = false,
		config = function()
			-- Define custom higlight groups for tabby
			local custom_higlights = function(colors)
				return {
					NotifyBackground = { bg = "#000000" },
					TabLine = { bg = colors.mantle, fg = colors.text },
					-- git-conflict
					DiffText = { bg = colors.rosewater, fg = colors.mantle },
					DiffAdd = { bg = colors.teal, fg = colors.mantle },
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
				flavour = "macchiato", -- latte, frappe, macchiato, mocha
				background = {
					light = "latte",
					dark = "macchiato",
				},
				transparent_background = true,
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
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {},
				custom_highlights = custom_higlights,
				integrations = {
					aerial = true,
					cmp = true,
					dap = {
						enabled = true,
						enable_ui = true, -- enable nvim-dap-ui
					},
					gitsigns = true,
					illuminate = true,
					indent_blankline = {
						enabled = true,
						scope_color = "sky", -- catppuccin color (eg. `lavender`) Default: text
						colored_indent_levels = false,
					},
					mason = true,
					native_lsp = { enabled = true },
					notify = true,
					telescope = true,
					treesitter = true,
					which_key = true,
				},
			})

			vim.cmd([[colorscheme catppuccin]])
		end,
	},
}
