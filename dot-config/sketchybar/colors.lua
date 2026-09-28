-- NOTE: Derive colors from the catppuccin flavor-of-choice by leveraging the Neovim plugin installed by Lazy.nvim.
-- Falls back to hardcoded mocha values if the plugin path isn't found.
local catppuccin_flavor = os.getenv("HOME") .. "/.local/share/nvim/lazy/catppuccin/lua/catppuccin/palettes/mocha.lua"

local ok, colors = pcall(dofile, catppuccin_flavor)
if not ok then
	colors = {
		rosewater = "#f5e0dc",
		flamingo = "#f2cdcd",
		pink = "#f5c2e7",
		mauve = "#cba6f7",
		red = "#f38ba8",
		maroon = "#eba0ac",
		peach = "#fab387",
		yellow = "#f9e2af",
		green = "#a6e3a1",
		teal = "#94e2d5",
		sky = "#89dceb",
		sapphire = "#74c7ec",
		blue = "#89b4fa",
		lavender = "#b4befe",
		text = "#cdd6f4",
		subtext1 = "#bac2de",
		subtext0 = "#a6adc8",
		overlay2 = "#9399b2",
		overlay1 = "#7f849c",
		overlay0 = "#6c7086",
		surface2 = "#585b70",
		surface1 = "#45475a",
		surface0 = "#313244",
		base = "#1e1e2e",
		mantle = "#181825",
		crust = "#11111b",
	}
end

-- NOTE: Convert catppuccin "#RRGGBB" to sketchybar "0xAARRGGBB"
local function hex(color, alpha)
	return "0x" .. (alpha or "ff") .. color:sub(2)
end

return {
	-- Named colors
	black = hex(colors.surface1),
	red = hex(colors.red),
	green = hex(colors.green),
	yellow = hex(colors.yellow),
	blue = hex(colors.blue),
	magenta = hex(colors.flamingo),
	cyan = hex(colors.teal),
	white = hex(colors.subtext0),
	orange = hex(colors.peach),
	pink = hex(colors.pink),
	comment = hex(colors.overlay2),
	grey = hex(colors.overlay2),

	-- Background scale
	bg0 = hex(colors.mantle),
	bg1 = hex(colors.base),
	bg2 = hex(colors.surface0),

	-- Foreground scale
	fg0 = hex(colors.text),
	fg1 = hex(colors.subtext0),
	fg2 = hex(colors.overlay1),

	-- Bar / UI surfaces (80% opacity)
	transparent = "0x00000000",
	bar = hex(colors.mantle, "CC"),
	bar_border = hex(colors.base, "CC"),
	background_1 = hex(colors.base, "CC"),
	background_2 = hex(colors.surface0, "CC"),
	popup_bg = hex(colors.mantle, "CC"),
	popup_border = hex(colors.base, "CC"),
	shadow = hex(colors.surface1),
}
