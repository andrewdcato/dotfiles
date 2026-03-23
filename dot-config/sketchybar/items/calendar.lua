local cal = sbar.add("item", "calendar", {
  position     = "center",
  padding_left = 15,
  update_freq  = 30,
  icon = {
    font          = { style = "Black", size = 12.0 },
    padding_right = 0,
  },
  label = {
    width = 70,
    align = "right",
  },
})

local function update()
  cal:set({
    icon  = { string = os.date("%A, %B %d") },
    label = { string = os.date("%I:%M %p") },
  })
end

cal:subscribe({"routine", "forced", "system_woke"}, update)
