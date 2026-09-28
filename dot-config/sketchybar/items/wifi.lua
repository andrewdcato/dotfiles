local icons = require("icons")

local wifi = sbar.add("item", "wifi", {
  position      = "right",
  padding_right = 7,
  icon          = { string = icons.wifi.disconnected },
  label         = { width = 0 },
})

local function update()
  sbar.exec("ipconfig getifaddr en0", function(ip_result, ip_code)
    local ip = ip_result:gsub("%s+$", "")
    if ip_code ~= 0 or ip == "" then
      wifi:set({
        icon  = { string = icons.wifi.disconnected },
        label = { string = "Disconnected" },
      })
      return
    end
    sbar.exec("/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I"
      .. " | awk -F ' SSID: ' '/ SSID: / {print $2}'", function(ssid_result)
      local ssid = ssid_result:gsub("%s+$", "")
      wifi:set({
        icon  = { string = icons.wifi.connected },
        label = { string = ssid .. " (" .. ip .. ")" },
      })
    end)
  end)
end

local function toggle_label()
  local info  = wifi:query()
  local width = info and info.label and tonumber(info.label.width) or 0
  sbar.animate("sin", 20, function()
    wifi:set({ label = { width = width == 0 and "dynamic" or 0 } })
  end)
end

wifi:subscribe({"wifi_change", "routine"}, update)
wifi:subscribe("mouse.clicked", toggle_label)
