local colors = require("colors")
local icons  = require("icons")

local SLIDER_WIDTH = 100

local volume_slider = sbar.add("slider", "volume", SLIDER_WIDTH, {
  position = "right",
  updates  = true,
  label    = { drawing = false },
  icon     = { drawing = false },
  slider = {
    highlight_color = colors.blue,
    width           = 0,
    background = {
      height        = 5,
      corner_radius = 3,
      color         = colors.background_2,
    },
    knob = {
      string  = "􀀁",
      drawing = true,
    },
  },
})

local volume_icon = sbar.add("item", "volume_icon", {
  position     = "right",
  padding_left = 10,
  icon = {
    string = icons.volume._100,
    width  = 0,
    align  = "left",
    color  = colors.grey,
    font   = { style = "Regular", size = 14.0 },
  },
  label = {
    width = 25,
    align = "left",
    font  = { style = "Regular", size = 14.0 },
  },
})

-- Track the last known volume for the delay check
local last_volume = -1

volume_slider:subscribe("volume_change", function(env)
  local volume = tonumber(env.INFO) or 0
  last_volume  = volume

  local icon = icons.volume._0
  if volume > 60 then
    icon = icons.volume._100
  elseif volume > 30 then
    icon = icons.volume._66
  elseif volume > 10 then
    icon = icons.volume._33
  elseif volume > 0 then
    icon = icons.volume._10
  end

  volume_icon:set({ label = { string = icon } })
  volume_slider:set({ slider = { percentage = volume } })

  local info = volume_slider:query()
  if info and tonumber(info.slider.width) == 0 then
    sbar.animate("tanh", 30, function()
      volume_slider:set({ slider = { width = SLIDER_WIDTH } })
    end)
  end

  local captured = volume
  sbar.delay(2, function()
    if last_volume == captured then
      sbar.animate("tanh", 30, function()
        volume_slider:set({ slider = { width = 0 } })
      end)
    end
  end)
end)

volume_slider:subscribe("mouse.clicked", function(env)
  sbar.exec("osascript -e 'set volume output volume " .. (env.PERCENTAGE or 50) .. "'")
end)

local function toggle_slider()
  local info = volume_slider:query()
  local width = info and tonumber(info.slider.width) or 0
  sbar.animate("tanh", 30, function()
    volume_slider:set({ slider = { width = width == 0 and SLIDER_WIDTH or 0 } })
  end)
end

local function toggle_devices()
  sbar.exec("which SwitchAudioSource 2>/dev/null", function(_, exit_code)
    if exit_code ~= 0 then return end

    sbar.remove("/volume.device.*/")
    volume_icon:set({ popup = { drawing = "toggle" } })

    sbar.exec("SwitchAudioSource -a -t output", function(devices_str)
      sbar.exec("SwitchAudioSource -t output -c", function(current_str)
        local current = current_str:gsub("%s+$", "")
        local counter = 0

        for device in devices_str:gmatch("[^\n]+") do
          if device ~= "" then
            counter = counter + 1
            local is_current = device == current
            local color      = is_current and colors.white or colors.grey
            local dev_item   = sbar.add("item", "volume.device." .. counter, {
              position = "popup.volume_icon",
              label    = { string = device, color = color },
            })
            local d = device
            dev_item:subscribe("mouse.clicked", function(_)
              sbar.exec("SwitchAudioSource -s '" .. d .. "'")
              sbar.set("/volume.device.*/", { label = { color = colors.grey } })
              dev_item:set({ label = { color = colors.white } })
              volume_icon:set({ popup = { drawing = false } })
            end)
          end
        end
      end)
    end)
  end)
end

volume_icon:subscribe("mouse.clicked", function(env)
  if env.BUTTON == "right" or env.MODIFIER == "shift" then
    toggle_devices()
  else
    toggle_slider()
  end
end)

-- Group the right-side system items with a shared background
sbar.add("bracket", "status",
  { "brew", "github.bell", "wifi", "volume_icon" },
  {
    background = {
      color        = colors.background_1,
      border_color = colors.background_2,
    },
  }
)
