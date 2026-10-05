local colors = require("colors")
local date_map = require("plugins.date_map")

local time = sbar.add("item", "clock", {
	position = "right",
	padding_left = 5,
	update_freq = 5,
	icon = { drawing = 0 },
})

local date = sbar.add("item", "calendar", {
	position = "right",
	padding_left = 15,
	update_freq = 30,
	icon = {
		font = { size = 18.0 },
		padding_right = 0,
	},
	label = {
		font = { style = "Black" },
	},
})

local function dateUpdate()
	date:set({
		icon = { string = date_map(tonumber(os.date("%d"))) },
		label = { string = os.date(" %a, %b %d") },
	})
end

local function timeUpdate()
	time:set({
		label = { string = os.date("%I:%M %p") },
	})
end

date:subscribe({ "routine", "forced", "system_woke" }, dateUpdate)
time:subscribe({ "routine", "forced", "system_woke" }, timeUpdate)

sbar.add(
	"bracket",
	"datetime",
	{ "time", "date" },
	{ background = {
		color = colors.background_1,
		border_color = colors.background_2,
	} }
)
