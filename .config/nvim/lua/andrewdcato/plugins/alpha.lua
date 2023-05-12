local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
	[[                               __                ]],
	[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
	[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
	[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
	[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}

dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", "<cmd>Telescope find_files<cr>"),
	dashboard.button("e", "  New file", "<cmd>ene <BAR> startinsert<cr>"),
	dashboard.button("p", "  Find project", "<cmd>Telescope project<cr>"),
	dashboard.button("r", "  Recently used files", "<cmd>Telescope oldfiles<cr>"),
	dashboard.button("t", "  Find text", "<cmd>Telescope live_grep<cr>"),
	dashboard.button("c", "  Configuration", "<cmd>e $MYVIMRC<cr>"),
	dashboard.button("q", "  Quit Neovim", "<cmd>qa<cr>"),
}

-- Footer must be a table so that its height is correctly measured
local num_plugins_loaded = #vim.fn.globpath(vim.fn.stdpath("data") .. "/site/pack/packer/start", "*", 0, 1)
if num_plugins_loaded <= 1 then
	dashboard.section.footer.val = { num_plugins_loaded .. " plugin ﮣ loaded" }
else
	dashboard.section.footer.val = { num_plugins_loaded .. " plugins ﮣ loaded" }
end
dashboard.section.footer.opts.hl = "Comment"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

-- Set paddings
local h_header = #dashboard.section.header.val
local h_buttons = #dashboard.section.buttons.val * 2 - 1
local h_footer = #dashboard.section.footer.val
local pad_tot = vim.o.lines - (h_header + h_buttons + h_footer)
local pad_1 = math.ceil(pad_tot * 0.25)
local pad_2 = math.ceil(pad_tot * 0.20)
local pad_3 = math.floor(pad_tot * 0.30)

dashboard.config.layout = {
	{ type = "padding", val = pad_1 },
	dashboard.section.header,
	{ type = "padding", val = pad_2 },
	dashboard.section.buttons,
	{ type = "padding", val = pad_3 },
	dashboard.section.footer,
}

vim.cmd(
	[[ au User AlphaReady if winnr('$') == 1 | set laststatus=0 showtabline=0 | endif | au BufUnload <buffer> set laststatus=3 showtabline=2 ]]
)

vim.api.nvim_create_autocmd("BufUnload", {
	buffer = 0,
	desc = "show cursor after alpha",
	callback = function()
		local hl = vim.api.nvim_get_hl_by_name("Cursor", true)
		hl.blend = 0
		vim.api.nvim_set_hl(0, "Cursor", hl)
		vim.opt.guicursor:remove("a:Cursor/lCursor")
	end,
})

alpha.setup(dashboard.opts)
