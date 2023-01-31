local options = {
	-- base ui config
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
	pumblend = 20,
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
}

for key, value in pairs(options) do
	vim.o[key] = value
end

-- Clipboard
vim.opt.clipboard:append("unnamedplus") -- use the system clipboard when yanking text

-- Misc
vim.opt.iskeyword:append("-") -- changes the "-" character to be considered part of the word
