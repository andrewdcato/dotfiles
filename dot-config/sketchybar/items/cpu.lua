local colors = require("colors")
local settings = require("settings")

local cpu_percent = sbar.add("item", "cpu.percent", {
	position = "right",
	width = 55,
	padding_right = 15,
	padding_left = 15,
	update_freq = 4,
	mach_helper = settings.helper,
	icon = {
		string = "􀫥",
		color = colors.orange,
		font = { size = 16.0 },
	},
	label = {
		string = "CPU",
		font = { style = "Heavy", size = 13.0 },
	},
})

sbar.add("bracket", "cpu", { cpu_percent.name }, { background = { drawing = false } })
