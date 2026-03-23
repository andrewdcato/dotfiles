local colors = require("colors")
local icons  = require("icons")

sbar.add("event", "brew_update")

local brew = sbar.add("item", "brew", {
  position      = "right",
  padding_right = 10,
  icon          = { string = "􀐛" },
  label         = { string = "?" },
})

local function update()
  sbar.exec("brew outdated | wc -l | tr -d ' '", function(result)
    local count = tonumber(result:gsub("%s+", "")) or 0
    local color = colors.red
    local label = tostring(count)

    if count >= 30 then
      color = colors.orange
    elseif count >= 10 then
      color = colors.yellow
    elseif count >= 1 then
      color = colors.white
    else
      color = colors.green
      label = icons.checkmark
    end

    brew:set({
      icon  = { color = color },
      label = { string = label },
    })
  end)
end

brew:subscribe({"routine", "brew_update"}, update)
