local colors = require("colors")
local icons  = require("icons")

local battery = sbar.add("item", "battery", {
  position      = "right",
  padding_left  = 0,
  padding_right = 5,
  update_freq   = 120,
  updates       = true,
  icon = {
    font = { style = "Regular", size = 19.0 },
  },
  label = { drawing = false },
})

local function update()
  sbar.exec("pmset -g batt", function(batt_info)
    local percentage = tonumber(batt_info:match("(%d+)%%"))
    if not percentage then return end

    local charging = batt_info:find("AC Power") ~= nil
    local icon     = icons.battery._100
    local color    = colors.white
    local drawing  = true

    if charging then
      icon    = icons.battery.charging
      drawing = false
    elseif percentage >= 90 then
      icon    = icons.battery._100
      drawing = false
    elseif percentage >= 60 then
      icon    = icons.battery._75
      drawing = false
    elseif percentage >= 30 then
      icon    = icons.battery._50
    elseif percentage >= 10 then
      icon    = icons.battery._25
      color   = colors.orange
    else
      icon  = icons.battery._0
      color = colors.red
    end

    battery:set({
      drawing = drawing,
      icon    = { string = icon, color = color },
    })
  end)
end

battery:subscribe({"routine", "power_source_change", "system_woke"}, update)
