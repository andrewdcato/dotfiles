local front_app = sbar.add("item", "front_app", {
  position = "left",
  display  = "active",
  label = {
    font = { style = "Black", size = 12.0 },
  },
  icon = {
    background = { drawing = true },
  },
  click_script = "open -a 'Mission Control'",
})

front_app:subscribe("front_app_switched", function(env)
  front_app:set({
    label = { string = env.INFO },
    icon  = { background = { image = "app." .. env.INFO } },
  })
end)
