local colors   = require("colors")
local icon_map = require("plugins.icon_map")

sbar.add("event", "aerospace_workspace_change")

-- Synchronously get initial icon strip for a workspace
local function initial_icon_strip(ws)
  local pipe = io.popen(
    "aerospace list-windows --workspace " .. ws
    .. " | awk -F'|' '{gsub(/^ *| *$/, \"\", $2); print $2}'"
  )
  if not pipe then return " —" end

  local strip = " "
  for app in pipe:lines() do
    if app ~= "" then
      strip = strip .. " " .. icon_map(app)
    end
  end
  pipe:close()

  return strip == " " and " —" or strip
end

-- Async reload of icon strip for a workspace; calls callback(strip)
local function reload_icon_strip(ws, callback)
  sbar.exec(
    "aerospace list-windows --workspace " .. ws
    .. " | awk -F'|' '{gsub(/^ *| *$/, \"\", $2); print $2}'",
    function(result)
      local strip = " "
      for app in result:gmatch("[^\n]+") do
        if app ~= "" then
          strip = strip .. " " .. icon_map(app)
        end
      end
      callback(strip == " " and " —" or strip)
    end
  )
end

-- Helper: read lines from a shell command synchronously
local function popen_lines(cmd)
  local pipe = io.popen(cmd)
  if not pipe then return {} end
  local lines = {}
  for line in pipe:lines() do
    if line ~= "" then table.insert(lines, line) end
  end
  pipe:close()
  return lines
end

-- Build space items for each monitor/workspace
local monitors = popen_lines("aerospace list-monitors | awk '{print $1}'")

for _, monitor_id in ipairs(monitors) do
  local workspaces = popen_lines("aerospace list-workspaces --monitor " .. monitor_id)

  for _, sid in ipairs(workspaces) do
    local space = sbar.add("item", "space." .. sid, {
      position     = "left",
      padding_left  = 2,
      padding_right = 2,
      display      = tonumber(monitor_id),
      icon = {
        string          = sid,
        padding_left    = 10,
        padding_right   = 10,
        highlight_color = colors.red,
      },
      label = {
        string          = initial_icon_strip(sid),
        padding_right   = 20,
        color           = colors.grey,
        highlight_color = colors.white,
        font            = "sketchybar-app-font:Regular:16.0",
        y_offset        = -1,
      },
      background = {
        color        = colors.background_1,
        border_color = colors.background_2,
      },
    })

    space:subscribe("mouse.clicked", function(env)
      if env.MODIFIER == "shift" then
        sbar.exec(
          "osascript -e 'return (text returned of (display dialog "
          .. "\"Name space " .. sid .. ":\" default answer \"\" "
          .. "with icon note buttons {\"Cancel\", \"Continue\"} "
          .. "default button \"Continue\"))'",
          function(label, code)
            if code == 0 then
              label = label:gsub("%s+$", "")
              local display = label == "" and sid or (sid .. " (" .. label .. ")")
              space:set({ icon = { string = display } })
            end
          end
        )
      elseif env.BUTTON ~= "right" then
        sbar.exec("aerospace workspace " .. sid)
      end
    end)

    space:subscribe("aerospace_workspace_change", function(env)
      local selected = env.FOCUSED_WORKSPACE == sid
      space:set({
        icon  = { highlight = selected },
        label = { highlight = selected },
        background = {
          border_color = selected and colors.cyan or colors.background_2,
        },
      })

      -- Reload icon strip for the workspaces that changed
      if env.FOCUSED_WORKSPACE == sid or env.PREV_WORKSPACE == sid then
        reload_icon_strip(sid, function(strip)
          sbar.animate("sin", 10, function()
            space:set({ label = { string = strip } })
          end)
        end)
      end
    end)
  end

  -- Hide empty workspaces at startup
  local empty = popen_lines("aerospace list-workspaces --monitor " .. monitor_id .. " --empty")
  for _, ws in ipairs(empty) do
    sbar.set("space." .. ws, { display = 0 })
  end
end

-- Space creator button — handles workspace visibility on changes
local space_creator = sbar.add("item", "space_creator", {
  position      = "left",
  padding_left  = 10,
  padding_right = 8,
  display       = "active",
  icon = {
    string = "􀆊",
    font   = { style = "Heavy", size = 16.0 },
    color  = colors.white,
  },
  label = { drawing = false },
})

space_creator:subscribe("aerospace_workspace_change", function(env)
  sbar.exec("aerospace list-monitors --focused | awk '{print $1}'", function(result)
    local focused_monitor = tonumber(result:gsub("%s+$", ""))
    if not focused_monitor then return end

    -- Show all non-empty workspaces on the focused monitor
    sbar.exec("aerospace list-workspaces --monitor focused --empty no", function(ws_result)
      for ws in ws_result:gmatch("[^\n]+") do
        if ws ~= "" then
          sbar.set("space." .. ws, { display = focused_monitor })
        end
      end
      sbar.set("space." .. env.FOCUSED_WORKSPACE, { display = focused_monitor })
    end)

    -- Hide empty workspaces
    sbar.exec("aerospace list-workspaces --monitor focused --empty", function(ws_result)
      for ws in ws_result:gmatch("[^\n]+") do
        if ws ~= "" then
          sbar.set("space." .. ws, { display = 0 })
        end
      end
    end)
  end)
end)
