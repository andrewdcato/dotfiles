local colors   = require("colors")
local settings = require("settings")

sbar.default({
  icon = {
    font = {
      family = settings.font,
      style  = "Bold",
      size   = 14.0,
    },
    color         = colors.fg1,
    padding_left  = settings.paddings,
    padding_right = settings.paddings,
  },
  label = {
    font = {
      family = settings.font,
      style  = "Semibold",
      size   = 13.0,
    },
    color         = colors.fg1,
    padding_left  = settings.paddings,
    padding_right = settings.paddings,
  },
  background = {
    border_width  = 2,
    corner_radius = 9,
    height        = 26,
  },
  popup = {
    background = {
      color         = colors.popup_bg,
      border_color  = colors.popup_border,
      border_width  = 2,
      corner_radius = 9,
      shadow        = { drawing = true },
    },
    blur_radius = 20,
  },
  padding_left  = settings.paddings,
  padding_right = settings.paddings,
  scroll_texts  = true,
  updates       = "when_shown",
})
