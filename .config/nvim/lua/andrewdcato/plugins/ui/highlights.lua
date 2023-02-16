-- NVIM-COLORIZER: https://github.com/norcalli/nvim-colorizer.lua
local colorizer_ok, colorizer = pcall(require, "nvim-colorizer")
if colorizer_ok then
	colorizer.setup({
		tailwind = true,
	})
end

-- TODO-COMMENTS: https://github.com/folke/todo-comments.nvim
local todos_ok, todos = pcall(require, "todo-comments")
if todos_ok then
	todos.setup()
end

-- INDENT-BLANKLINE: https://github.com/lukas-reineke/indent-blankline.nvim
local indent_blankline_ok, indent_blankline = pcall(require, "indent_blankline")
if indent_blankline_ok then
	vim.opt.list = true
	vim.opt.listchars:append("eol:↴")

	indent_blankline.setup({
		show_end_of_line = true,
		show_current_context = true,
		show_current_context_start = true,
	})
end

-- MODES.NVIM: https://github.com/mvllow/modes.nvim
local modes_ok, modes = pcall(require, "modes")
if modes_ok then
	modes.setup({
		colors = {
			copy = "#B48EAD",
			delete = "#BF616A",
			insert = "#A3BE8C",
			visual = "#B48EAD",
		},
		-- Set opacity for cursorline and number background
		line_opacity = 0.60,
		-- Enable cursor highlights
		set_cursor = true,
		-- Enable cursorline initially, and disable cursorline for inactive windows
		-- or ignored filetypes
		set_cursorline = true,
		-- Enable line number highlights to match cursorline
		set_number = true,
		-- Disable modes highlights in specified filetypes
		-- Please PR commonly ignored filetypes
		ignore_filetypes = { "NvimTree", "TelescopePrompt", "lspsagaoutline" },
	})
end

-- vim-illuminate: https://github.com/RRethy/vim-illuminate
local illuminate_ok, illuminate = pcall(require, "illuminate")
if illuminate_ok then
	illuminate.configure({
		filetypes_denylist = {
			"NvimTree",
			"alpha",
			"packer",
			"lspsagaoutline",
		},
	})
end

-- gitsigns.nvim: https://github.com/lewis6991/gitsigns.nvim
local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
if gitsigns_ok then
	gitsigns.setup({
		numhl = true,
	})
end
