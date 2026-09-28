local colors = require("colors")

sbar.bar({
  height        = 45,
  color         = colors.bar,
  border_color  = colors.bar_border,
  border_width  = 2,
  margin        = -2,
  padding_left  = 10,
  padding_right = 10,
  position      = "top",
  shadow        = false,
  sticky        = true,
  topmost       = "window",
  y_offset      = -5,
  background    = {
    blur_radius   = 90,
    corner_radius = 9,
  },
})
