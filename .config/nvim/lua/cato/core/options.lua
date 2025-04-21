local options = {
	-- base ui config
	guifont = { "Operator Mono Lig Book", "h15" },
	relativenumber = true,
	number = true,
	showmatch = true,
	colorcolumn = "120",
	termguicolors = true,
	background = "dark", -- force dark mode in themes that support it
	signcolumn = "yes",
	smartindent = true,
	backspace = "indent,eol,start",
	scrolloff = 8, -- keep X lines around the cursor at all times
	pumblend = 0,
	winblend = 0,
	showmode = false,
	cursorline = false,
	-- text wrapping
	textwidth = 0,
	wrapmargin = 0,
	wrap = true,
	linebreak = true,
	-- spacing
	tabstop = 2,
	softtabstop = 2,
	shiftwidth = 2,
	expandtab = true, -- convert tabs to spaces like a civilized person
	-- search tweaks
	ignorecase = true, -- make search case-insensitive
	smartcase = true, -- make search case-sensitive when starting w/capitals
	-- completeopt settings
	completeopt = { "menuone", "noselect", "noinsert" },
	shortmess = vim.opt.shortmess + { c = true },
	-- modeline
	modeline = true,
	modelines = 5,
	-- spell check
	-- spell = true,
	-- spelllang = { "en_us" },
}

for key, value in pairs(options) do
	vim.opt[key] = value
end

-- Clipboard
vim.opt.clipboard:append("unnamedplus") -- use the system clipboard when yanking text

-- Misc
vim.cmd([[let &t_Cs = "\e[4:3m"]]) -- Undercurl
vim.cmd([[let &t_Ce = "\e[4:0m"]]) -- Undercurl
vim.opt.guicursor = "a:block-Cursor" -- block cursor in all modes
vim.opt.guicursor = "i-v:blinkon10" -- blink the cursor in insert or visual mode
vim.opt.iskeyword:append("-") -- changes the "-" character to be considered part of the word

vim.api.nvim_set_option("updatetime", 300)
vim.api.nvim_set_option("list", false)
vim.api.nvim_set_option("splitright", true)
vim.api.nvim_set_option("laststatus", 3)
