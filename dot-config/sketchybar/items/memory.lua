local colors = require("colors")
local settings = require("settings")

local memory_percent = sbar.add("item", "memory.percent", {
	position = "right",
	width = 55,
	padding_right = 15,
	update_freq = 4,
	mach_helper = settings.helper,
	icon = {
		string = "􀫦",
		color = colors.cyan,
		font = { size = 16.0 },
	},
	label = {
		string = "MEM",
		font = { style = "Heavy", size = 13.0 },
	},
})

sbar.add("bracket", "memory", { memory_percent.name }, { background = { drawing = false } })
