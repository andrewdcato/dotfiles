local installed, modes = pcall(require, "modes")
if not installed then
	return
end

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
