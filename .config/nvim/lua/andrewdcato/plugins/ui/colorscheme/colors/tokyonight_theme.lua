local tokyo_ok, tokyo = pcall(require, "tokyonight")
if not tokyo_ok then
	return
end

tokyo.setup({
	style = "storm",
	transparent = true,
	terminal_colors = true,
	-- styles = {
	-- 	sidebars = "dark",
	-- 	floats = "dark",
	-- },
	sidebars = { "NvimTree", "lspsagaoutline" },
	on_colors = function(colors)
		-- nvim-tree colors
		colors.git.add = colors.green
		colors.git.delete = colors.red
		colors.git.change = colors.yellow

		-- gitsigns.nvim colors
		colors.gitSigns.add = colors.green
		colors.gitSigns.delete = colors.red
		colors.gitSigns.change = colors.yellow
	end,
	on_highlights = function(highlights, colors)
		-- header and footer of feline
		highlights.UserTLHead = { bg = colors.blue, fg = colors.black }
		highlights.UserTlHeadSep = { bg = colors.bg_dark, fg = colors.blue }
		-- active tab
		highlights.UserTLActive = { bg = colors.cyan, fg = colors.bg_dark }
		highlights.UserTlActiveSepL = { bg = colors.cyan, fg = colors.bg_dark }
		highlights.UserTlActiveSepR = { bg = colors.bg_dark, fg = colors.cyan }
		-- inactive tab
		highlights.UserTLInactive = { bg = colors.bg, fg = colors.fg_gutter }
		highlights.UserTLInactiveSepL = { bg = colors.bg, fg = colors.bg_dark }
		highlights.UserTLInactiveSepR = { bg = colors.bg_dark, fg = colors.bg }
		-- active window
		highlights.UserTLTopWin = { bg = colors.terminal_black, fg = colors.cyan }
		highlights.UserTLTopWinL = { bg = colors.terminal_black, fg = colors.bg_dark }
		highlights.UserTLTopWinR = { bg = colors.bg_dark, fg = colors.terminal_black }
		-- inactive window(s)
		highlights.UserTLWin = { bg = colors.bg_highlight, fg = colors.comment }
		highlights.UserTLWinL = { bg = colors.bg_highlight, fg = colors.bg_dark }
		highlights.UserTLWinR = { bg = colors.bg_dark, fg = colors.bg_highlight }
	end,
})

vim.cmd([[colorscheme tokyonight]])
