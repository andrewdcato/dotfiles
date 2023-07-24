local wezterm = require("wezterm")
local tab = require("tab")

local config = {}

config.color_scheme = "Catppuccin Macchiato"
config.enable_scroll_bar = false
config.window_background_opacity = 0.9
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.ssh_domains = {
	{
		name = "anton",
		remote_address = "127.0.0.1",
		username = "andrewcato",
	},
}

config.line_height = 1.05
config.font_size = 16
config.font = wezterm.font_with_fallback({
	"OperatorMonoLig Nerd Font",
	"JetBrainsMono Nerd Font Mono",
	"Hack Nerd Font",
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
