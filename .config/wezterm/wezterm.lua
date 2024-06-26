local wezterm = require("wezterm")
local tab = require("tab")

local config = {}

config.term = "xterm-256color"
config.color_scheme = "nordfox"
config.enable_scroll_bar = false
config.window_background_opacity = 0.80
config.macos_window_background_blur = 80
config.window_padding = {
	left = 5,
	right = 0,
	top = 0,
	bottom = 0,
}

config.line_height = 1.05
config.font_size = 16
config.font = wezterm.font_with_fallback({
	"OperatorMonoLig Nerd Font",
	"Hack Nerd Font Mono",
	"icomoon",
})

config.keys = {
	{
		key = "j",
		mods = "CMD",
		action = wezterm.action.SendString("\x02\x54 \n"),
	},
}

tab.setup(config)

return config
