local catppuccin_ok, catppuccin = pcall(require, "catppuccin")
if not catppuccin_ok then
	return
end

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
	}
end

catppuccin.setup({
	flavour = "macchiato", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "macchiato",
	},
	transparent_background = true,
	show_end_of_buffer = false, -- show the '~' characters after the end of buffers
	term_colors = false,
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
		cmp = true,
		gitsigns = true,
		illuminate = true,
		indent_blankline = { enabled = true, colored_indent_labels = true },
		mason = true,
		mini = false,
		native_lsp = { enabled = true },
		notify = true,
		nvimtree = true,
		telescope = true,
		treesitter = true,
		which_key = true,
	},
})

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")
