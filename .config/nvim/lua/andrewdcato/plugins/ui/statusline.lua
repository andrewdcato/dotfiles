local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
	return
end

local icons = require("andrewdcato.util").icons

local branch_component = { "b:gitsigns_head", icon = icons.git.branch }

local diff_component = {
	"diff",
	source = function()
		local gitsigns = vim.b.gitsigns_status_dict
		if gitsigns then
			return {
				added = gitsigns.added,
				modified = gitsigns.modified,
				removed = gitsigns.removed,
			}
		end
	end,
	symbols = {
		added = icons.git.added .. " ",
		modified = icons.git.modified .. " ",
		removed = icons.git.removed .. " ",
	},
}

local diagnostics_component = {
	"diagnostics",
	{
		sources = { "nvim_lsp", "nvim_diagnostic" },
		symbols = {
			error = icons.diagnostics.error,
			warn = icons.diagnostics.warn,
			info = icons.diagnostics.info,
			hint = icons.diagnostics.hint,
		},
		colored = true,
		update_on_insert = true,
	},
}

local disabled_filetypes = {
	statusline = { "alpha", "lspsagaoutline" },
	winbar = { "alpha", "lspsagaoutline" },
}

vim.opt.laststatus = 3

-- Override 'encoding': Don't display if encoding is UTF-8.
local encoding = function()
	local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
	return ret
end

-- fileformat: Don't display if &ff is unix.
local fileformat = function()
	local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
	return ret
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "catppuccin",
		component_separators = { left = "", right = "" },
		section_separators = { left = " ", right = " " },
		disabled_filetypes = disabled_filetypes,
	},
	sections = {
		lualine_a = {
			{
				"mode",
				icon = "",
				fmt = function(str)
					return str:sub(1, 3):lower()
				end,
			},
		},
		lualine_b = { branch_component, diff_component, diagnostics_component },
		lualine_c = {
			{
				"filetype",
				padding = { left = 0, right = 0 },
				colored = true,
				icon_only = true,
				separator = "",
			},
			"filename",
		},
		lualine_x = { encoding, fileformat },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	extensions = {
		"nvim-dap-ui",
		"nvim-tree",
	},
})
