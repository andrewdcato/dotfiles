local icons = require("andrewdcato.util").icons
-- local bufferline_ok, bufferline = pcall(require, "bufferline")
-- if bufferline_ok then
-- 	bufferline.setup({
-- 		options = {
-- 			indicator = { style = "underline" },
-- 			diagnostics = "nvim_lsp",
-- 			offsets = {
-- 				{
-- 					filetype = "NvimTree",
-- 					text = "File Explorer",
-- 					text_align = "center",
-- 					separator = true,
-- 				},
-- 				{
-- 					filetype = "lspsagaoutline",
-- 					text = "Outline",
-- 					text_align = "center",
-- 					separator = true,
-- 				},
-- 			},
-- 			separator_style = "thick",
-- 		},
-- 	})
-- end

local tabby_ok, tabby = pcall(require, "tabby")
if tabby_ok then
	local filename = require("tabby.filename")

	local cwd = function()
		return "  " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":~") .. " "
	end

	-- TODO: fix spacing between bufferline elements
	local line = {
		hl = "TabLine",
		layout = "active_tab_with_wins",
		head = {
			{ cwd, hl = "UserTLHead" },
			{ icons.separators.hard.left, hl = "UserTLHeadSep" },
		},
		active_tab = {
			label = function(tabid)
				return {
					"  " .. tabid .. " ",
					hl = "UserTLActive",
				}
			end,
			left_sep = { icons.separators.hard.left, hl = "UserTLActiveSepL" },
			right_sep = { icons.separators.hard.left, hl = "UserTLActiveSepR" },
			margin = "",
		},
		inactive_tab = {
			label = function(tabid)
				return {
					"  " .. tabid .. " ",
					hl = "UserTLInactive",
				}
			end,
			left_sep = { icons.separators.hard.left, hl = "UserTLInactiveSepL" },
			right_sep = { icons.separators.hard.left, hl = "UserTLInactiveSepR" },
		},
		top_win = {
			label = function(winid)
				return {
					"  " .. filename.unique(winid) .. " ",
					hl = "UserTLTopWin",
				}
			end,
			left_sep = { icons.separators.hard.left, hl = "UserTLTopWinL" },
			right_sep = { icons.separators.hard.left, hl = "UserTLTopWinR" },
			margin = "",
		},
		win = {
			label = function(winid)
				return {
					"  " .. filename.unique(winid) .. " ",
					hl = "UserTLWin",
				}
			end,
			left_sep = { icons.separators.hard.left, hl = "UserTLWinL" },
			right_sep = { icons.separators.hard.left, hl = "UserTLWinR" },
			margin = "",
		},
		tail = {
			{ icons.separators.hard.right, hl = "UserTLHeadSep" },
			{ "  ", hl = "UserTLHead" },
		},
	}

	tabby.setup({
		tabline = line,
	})
end

local barbecue_ok, barbecue = pcall(require, "barbecue")
if barbecue_ok then
	barbecue.setup({
		symbols = {
			modified = icons.git.modified,
		},
		kinds = icons.kinds,
	})
end
