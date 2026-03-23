local colors   = require("colors")
local settings = require("settings")

local cpu_top = sbar.add("item", "cpu.top", {
  position      = "right",
  width         = 0,
  padding_right = 15,
  y_offset      = 6,
  icon          = { drawing = false },
  label = {
    string = "CPU",
    font   = { style = "Semibold", size = 7.0 },
  },
})

local cpu_percent = sbar.add("item", "cpu.percent", {
  position      = "right",
  width         = 55,
  padding_right = 15,
  y_offset      = -4,
  update_freq   = 4,
  mach_helper   = settings.helper,
  icon          = { drawing = false },
  label = {
    string = "CPU",
    font   = { style = "Heavy", size = 12.0 },
  },
})

local cpu_sys = sbar.add("graph", "cpu.sys", 75, {
  position   = "right",
  width      = 0,
  label      = { drawing = false },
  icon       = { drawing = false },
  graph      = { color = colors.red, fill_color = colors.red },
  background = { height = 30, drawing = true, color = colors.transparent },
})

local cpu_user = sbar.add("graph", "cpu.user", 75, {
  position   = "right",
  label      = { drawing = false },
  icon       = { drawing = false },
  graph      = { color = colors.blue, fill_color = colors.blue },
  background = { height = 30, drawing = true, color = colors.transparent },
})

sbar.add("bracket", "cpu",
  { cpu_top.name, cpu_percent.name, cpu_sys.name, cpu_user.name },
  {}
)
