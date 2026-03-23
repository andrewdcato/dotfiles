local colors   = require("colors")
local settings = require("settings")

local memory_top = sbar.add("item", "memory.top", {
  position      = "right",
  width         = 0,
  padding_right = 15,
  y_offset      = 6,
  icon          = { drawing = false },
  label = {
    string = "MEM",
    font   = { style = "Semibold", size = 7.0 },
  },
})

local memory_percent = sbar.add("item", "memory.percent", {
  position      = "right",
  width         = 55,
  padding_right = 15,
  y_offset      = -4,
  update_freq   = 4,
  mach_helper   = settings.helper,
  icon          = { drawing = false },
  label = {
    string = "MEM",
    font   = { style = "Heavy", size = 12.0 },
  },
})

local memory_used = sbar.add("graph", "memory.used", 75, {
  position   = "right",
  width      = 0,
  label      = { drawing = false },
  icon       = { drawing = false },
  graph      = { color = colors.green, fill_color = colors.green },
  background = { height = 30, drawing = true, color = colors.transparent },
})

local memory_compressed = sbar.add("graph", "memory.compressed", 75, {
  position   = "right",
  label      = { drawing = false },
  icon       = { drawing = false },
  graph      = { color = colors.yellow, fill_color = colors.yellow },
  background = { height = 30, drawing = true, color = colors.transparent },
})

sbar.add("bracket", "memory",
  { memory_top.name, memory_percent.name, memory_used.name, memory_compressed.name },
  {}
)
