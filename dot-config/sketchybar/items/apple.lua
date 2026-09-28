local colors = require("colors")
local icons  = require("icons")

local apple = sbar.add("item", "apple.logo", {
  position      = "left",
  padding_right = 15,
  icon = {
    string = icons.apple,
    font   = { style = "Black", size = 16.0 },
    color  = colors.blue,
  },
  label  = { drawing = false },
  popup  = { height = 35 },
})

apple:subscribe("mouse.clicked", function(_)
  apple:set({ popup = { drawing = "toggle" } })
end)

local prefs = sbar.add("item", "apple.prefs", {
  position = "popup.apple.logo",
  icon     = { string = icons.preferences },
  label    = { string = "Preferences" },
})

prefs:subscribe("mouse.clicked", function(_)
  sbar.exec("open -a 'System Settings'")
  apple:set({ popup = { drawing = false } })
end)

local activity = sbar.add("item", "apple.activity", {
  position = "popup.apple.logo",
  icon     = { string = icons.activity },
  label    = { string = "Activity" },
})

activity:subscribe("mouse.clicked", function(_)
  sbar.exec("open -a 'Activity Monitor'")
  apple:set({ popup = { drawing = false } })
end)

local lock = sbar.add("item", "apple.lock", {
  position = "popup.apple.logo",
  icon     = { string = icons.lock },
  label    = { string = "Lock Screen" },
})

lock:subscribe("mouse.clicked", function(_)
  sbar.exec("pmset displaysleepnow")
  apple:set({ popup = { drawing = false } })
end)
