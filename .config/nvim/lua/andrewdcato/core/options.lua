local opt = vim.opt

-- Base UI config
opt.relativenumber = true
opt.number = true
opt.showmatch = true
opt.colorcolumn = "120"
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Text Wrapping
opt.textwidth = 0
opt.wrapmargin = 0
opt.wrap = true
opt.linebreak = true

-- Spacing
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

-- Keyboard fixes
opt.backspace = "indent,eol,start"

-- Window splitting
opt.splitright = true
opt.splitbelow = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Clipboard
opt.clipboard:append("unnamedplus") -- use the system clipboard when yanking text

-- Misc
opt.iskeyword:append("-") -- changes the "-" character to be considered part of the word
