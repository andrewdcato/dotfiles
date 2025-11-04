# Refactoring Sketchybar Config to sbar-lua

## Overview

Your current configuration uses the traditional bash-based approach with shell scripts. The **sbar-lua** API provides a more modern, performant, and maintainable approach using Lua.

## Key Differences

**Current (Bash):**
- Configuration in `sketchybarrc` (bash script)
- Items defined in separate `.sh` files
- Plugins are bash scripts that call `sketchybar --set`
- Colors/icons exported as shell variables
- External helper process in C

**Future (sbar-lua):**
- Configuration in `init.lua`
- Items defined as Lua tables
- Plugins are Lua functions or scripts
- Colors/icons as Lua tables
- Native Lua integration

## New Structure

```
dot-config/sketchybar/
├── init.lua              # Main config (replaces sketchybarrc)
├── colors.lua            # Color definitions (replaces colors.sh)
├── icons.lua             # Icon definitions (replaces icons.sh)
├── items/                # Item definitions
│   ├── apple.lua
│   ├── spaces.lua
│   ├── battery.lua
│   └── ...
└── plugins/              # Plugin scripts
    ├── battery.lua
    ├── space.lua
    └── ...
```

## Step-by-Step Refactoring Guide

### 1. Convert `colors.sh` to `colors.lua`

```lua
-- colors.lua
return {
  black = 0xff45475a,
  red = 0xfff38ba8,
  green = 0xffa6e3a1,
  yellow = 0xfff9e2af,
  blue = 0xff89b4fa,
  magenta = 0xfff2cdcd,
  cyan = 0xff794e2d5,
  white = 0xffa6adc8,
  orange = 0xffFFB86C,
  pink = 0xfff5c2e7,
  
  comment = 0xff9399b2,
  
  bg0 = 0xff181825,
  bg1 = 0xff1e1e2e,
  bg2 = 0xff313244,
  
  fg0 = 0xffcdd6f4,
  fg1 = 0xffa6adc8,
  fg2 = 0xff7f849c,
  
  sel0 = 0xff3e4a5b,
  sel1 = 0xff4f6074,
  
  bar = 0xCC181825,
  bar_border = 0xCC1e1e2e,
  background_1 = 0xCC1e1e2e,
  background_2 = 0xCC313244,
  popup_background = 0xCC181825,
  popup_border = 0xCC1e1e2e,
  shadow = 0xff45475a,
}
```

### 2. Convert `icons.sh` to `icons.lua`

```lua
-- icons.lua
return {
  -- General
  loading = "􀖇",
  apple = "􀣺",
  preferences = "􀺽",
  activity = "􀒓",
  lock = "􀒳",
  bell = "􀋚",
  bell_dot = "􀝗",
  
  -- Git
  git_issue = "􀍷",
  git_discussion = "􀒤",
  git_pull_request = "􀙡",
  git_commit = "􀡚",
  git_indicator = "􀂓",
  
  -- Yabai
  yabai_stack = "􀏭",
  yabai_fullscreen_zoom = "􀏜",
  yabai_parent_zoom = "􀥃",
  yabai_float = "􀢌",
  yabai_grid = "􀧍",
  
  -- Battery
  battery_100 = "􀛨",
  battery_75 = "􀺸",
  battery_50 = "􀺶",
  battery_25 = "􀛩",
  battery_0 = "􀛪",
  battery_charging = "􀢋",
  
  -- Volume
  volume_100 = "􀊩",
  volume_66 = "􀊧",
  volume_33 = "􀊥",
  volume_10 = "􀊡",
  volume_0 = "􀊣",
  
  -- WiFi
  wifi_connected = "􀙇",
  wifi_disconnected = "􀙈",
}
```

### 3. Convert `sketchybarrc` to `init.lua`

```lua
-- init.lua
local colors = require("colors")
local icons = require("icons")

-- Configuration constants
local FONT = "SF Pro"
local PADDINGS = 3

-- Bar configuration
sbar.bar({
  height = 45,
  color = colors.bar,
  border_color = colors.bar_border,
  border_width = 2,
  corner_radius = 9,
  margin = -2,
  padding_left = 10,
  padding_right = 10,
  position = "top",
  sticky = "on",
  topmost = "window",
  y_offset = -5,
  blur_radius = 90,
  shadow = "off",
})

-- Default item styles
sbar.default({
  icon = {
    color = colors.fg1,
    font = FONT .. ":Bold:14.0",
    padding_left = PADDINGS,
    padding_right = PADDINGS,
  },
  label = {
    color = colors.fg1,
    font = FONT .. ":Semibold:13.0",
    padding_left = PADDINGS,
    padding_right = PADDINGS,
  },
  background = {
    border_width = 2,
    corner_radius = 9,
    height = 26,
  },
  popup = {
    background = {
      color = colors.popup_background,
      border_color = colors.popup_border,
      border_width = 2,
      corner_radius = 9,
      shadow = { drawing = true },
    },
    blur_radius = 20,
  },
  padding_left = PADDINGS,
  padding_right = PADDINGS,
  scroll_texts = "on",
  updates = "when_shown",
})

-- Load items
require("items.apple")
require("items.spaces")
require("items.yabai")
require("items.front_app")
require("items.calendar")
require("items.brew")
require("items.github")
require("items.wifi")
require("items.battery")
require("items.volume")
require("items.cpu")

-- Enable hotload
sbar.hotload(true)

-- Initial update
sbar.update()
```

### 4. Convert Item Files (Example: `items/battery.lua`)

```lua
-- items/battery.lua
local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local battery = sbar.add("item", "battery", {
  position = "right",
  icon = {
    font = settings.font .. ":Regular:19.0",
  },
  label = {
    drawing = false,
  },
  padding_right = 5,
  padding_left = 0,
  update_freq = 120,
})

battery:subscribe("power_source_change", function()
  sbar.exec("pmset -g batt", function(batt_info)
    local percentage = tonumber(string.match(batt_info, "(%d+)%%"))
    local charging = string.find(batt_info, "AC Power") ~= nil
    
    local icon = icons.battery_100
    local color = colors.white
    local drawing = false
    
    if charging then
      icon = icons.battery_charging
    elseif percentage >= 90 then
      icon = icons.battery_100
      drawing = false
    elseif percentage >= 60 then
      icon = icons.battery_75
      drawing = false
    elseif percentage >= 30 then
      icon = icons.battery_50
      drawing = true
    elseif percentage >= 10 then
      icon = icons.battery_25
      color = colors.orange
      drawing = true
    else
      icon = icons.battery_0
      color = colors.red
      drawing = true
    end
    
    battery:set({
      icon = { value = icon, color = color },
      drawing = drawing,
    })
  end)
end)

battery:subscribe("system_woke", function()
  battery:trigger()
end)

return battery
```

### 5. Convert Plugin Scripts (Example: `items/spaces.lua`)

```lua
-- items/spaces.lua
local colors = require("colors")
local settings = require("settings")

local space_icons = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"}
local spaces = {}

for i, icon in ipairs(space_icons) do
  local space = sbar.add("space", "space." .. i, {
    space = i,
    icon = {
      string = icon,
      padding_left = 10,
      padding_right = 10,
      highlight_color = colors.red,
    },
    label = {
      padding_right = 20,
      color = colors.fg2,
      highlight_color = colors.cyan,
      font = "sketchybar-app-font:Regular:16.0",
      y_offset = -1,
    },
    padding_left = 2,
    padding_right = 2,
    background = {
      color = colors.background_1,
      border_color = colors.fg2,
    },
  })
  
  space:subscribe("space_change", function(env)
    local selected = env.SELECTED == "true"
    space:set({
      icon = { highlight = selected },
      label = { highlight = selected },
      background = {
        border_color = selected and colors.cyan or colors.background_2
      },
    })
  end)
  
  space:subscribe("mouse.clicked", function(env)
    if env.BUTTON == "right" then
      sbar.exec("yabai -m space --destroy " .. i)
    else
      sbar.exec("yabai -m space --focus " .. i)
    end
  end)
  
  spaces[i] = space
end

-- Space creator
local space_creator = sbar.add("item", "space_creator", {
  position = "left",
  icon = {
    string = "􀆊",
    font = settings.font .. ":Heavy:16.0",
    color = colors.blue,
  },
  label = { drawing = false },
  padding_left = 10,
  padding_right = 8,
  display = "active",
})

space_creator:subscribe("mouse.clicked", function()
  sbar.exec("yabai -m space --create")
end)

space_creator:subscribe("space_windows_change", function()
  -- Update logic here
end)

return spaces
```

### 6. Convert Apple Menu with Popup (Example: `items/apple.lua`)

```lua
-- items/apple.lua
local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local apple_logo = sbar.add("item", "apple.logo", {
  position = "left",
  icon = {
    string = icons.apple,
    font = settings.font .. ":Black:16.0",
    color = colors.blue,
  },
  label = { drawing = false },
  padding_right = 15,
  popup = { height = 35 },
})

apple_logo:subscribe("mouse.clicked", function()
  apple_logo:set({ popup = { drawing = "toggle" } })
end)

-- Popup items
local prefs = sbar.add("item", "apple.prefs", {
  position = "popup." .. apple_logo.name,
  icon = { string = icons.preferences },
  label = { string = "Preferences" },
})

prefs:subscribe("mouse.clicked", function()
  sbar.exec("open -a 'System Settings'")
  apple_logo:set({ popup = { drawing = false } })
end)

local activity = sbar.add("item", "apple.activity", {
  position = "popup." .. apple_logo.name,
  icon = { string = icons.activity },
  label = { string = "Activity" },
})

activity:subscribe("mouse.clicked", function()
  sbar.exec("open -a 'Activity Monitor'")
  apple_logo:set({ popup = { drawing = false } })
end)

local lock = sbar.add("item", "apple.lock", {
  position = "popup." .. apple_logo.name,
  icon = { string = icons.lock },
  label = { string = "Lock Screen" },
})

lock:subscribe("mouse.clicked", function()
  sbar.exec("pmset displaysleepnow")
  apple_logo:set({ popup = { drawing = false } })
end)

return apple_logo
```

## Benefits of Refactoring to sbar-lua

1. **Performance**: Lua is much faster than spawning bash processes
2. **Type Safety**: Better structure and error detection
3. **Maintainability**: Cleaner code organization
4. **Hot Reloading**: Faster iteration during development
5. **Native Integration**: Direct access to sketchybar's internal state
6. **No Helper Process**: The C helper may not be needed depending on what it does

## Migration Steps

1. **Install sbar-lua** if not already installed
2. **Create new file structure** with `.lua` files
3. **Convert colors and icons** first (simple translation)
4. **Convert main config** (`init.lua`)
5. **Convert items one by one** (start with simple ones like battery)
6. **Test each item** as you convert it
7. **Convert complex items** (spaces, apple menu with popups)
8. **Remove old bash files** once everything works
9. **Update your stow/dotfile management** to exclude old files

## Testing Strategy

```bash
# Backup your current config
cp -r ~/.config/sketchybar ~/.config/sketchybar.backup

# Test the new config
sketchybar --reload

# If issues occur, revert
rm -rf ~/.config/sketchybar
mv ~/.config/sketchybar.backup ~/.config/sketchybar
sketchybar --reload
```

## Items to Convert

From your current config:
- apple.sh → apple.lua ✓ (example provided)
- spaces.sh → spaces.lua ✓ (example provided)
- battery.sh → battery.lua ✓ (example provided)
- yabai.sh → yabai.lua
- front_app.sh → front_app.lua
- calendar.sh → calendar.lua
- brew.sh → brew.lua
- github.sh → github.lua
- wifi.sh → wifi.lua
- volume.sh → volume.lua
- cpu.sh → cpu.lua

## Notes

- The C helper in `dot-config/sketchybar/helper/` may not be needed with sbar-lua
- All bash plugins will need to be converted to Lua
- Event subscriptions work differently - use callbacks instead of SENDER variables
- Environment variables (like $NAME, $SENDER) become function parameters in Lua
