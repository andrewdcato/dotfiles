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

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
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
					indent_blankline = { enabled = true, colored_indent_labels = true },
					mason = true,
					native_lsp = { enabled = true },
					notify = true,
					telescope = true,
					treesitter = true,
					which_key = true,
				},
			})

			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		dependencies = { "roobert/tailwindcss-colorizer-cmp.nvim" },
		config = function()
			require("colorizer").setup({
				"css",
				"lua",
				"javascript",
				"typescript",
				"tailwind",
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			local indent_blankline = require("indent_blankline")
			vim.opt.list = true
			vim.opt.listchars:append("eol:↴")

			require("indent_blankline").setup({
				show_end_of_line = true,
				show_current_context = true,
				show_current_context_start = true,
			})
		end,
	},
	{
		"mvllow/modes.nvim",
		config = function()
			require("modes").setup({
				colors = {
					copy = "#B48EAD",
					delete = "#BF616A",
					insert = "#A6DA95",
					visual = "#F0C6C6",
				},
				-- Set opacity for cursorline and number background
				line_opacity = 0.20,
				-- Enable cursor highlights
				set_cursor = true,
				-- Enable cursorline initially, and disable cursorline for inactive windows
				-- or ignored filetypes
				set_cursorline = true,
				-- Enable line number highlights to match cursorline
				set_number = true,
				-- Disable modes highlights in specified filetypes
				-- Please PR commonly ignored filetypes
				ignore_filetypes = { "neo-tree", "TelescopePrompt", "lspsagaoutline" },
			})
		end,
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				filetypes_denylist = {
					"neo-tree",
					"alpha",
					"lspsagaoutline",
				},
			})
		end,
	},
}
