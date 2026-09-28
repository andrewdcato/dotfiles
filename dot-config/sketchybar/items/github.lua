local colors = require("colors")
local icons  = require("icons")

sbar.add("event", "github.update")

local github = sbar.add("item", "github.bell", {
  position      = "right",
  padding_right = 6,
  update_freq   = 180,
  icon = {
    string = icons.bell,
    font   = { style = "Bold", size = 15.0 },
    color  = colors.blue,
  },
  label = {
    string          = icons.loading,
    highlight_color = colors.blue,
  },
  popup = { align = "right" },
})

-- Template item for notification rows; cloned entries are added dynamically
sbar.add("item", "github.template", {
  position      = "popup.github.bell",
  drawing       = false,
  padding_left  = 7,
  padding_right = 7,
  background    = { corner_radius = 12 },
  icon = {
    background = {
      height   = 2,
      y_offset = -12,
    },
  },
})

local function update()
  sbar.exec("gh api notifications", function(notifications)
    if type(notifications) ~= "table" then
      github:set({ label = { string = "!" } })
      return
    end

    local count = #notifications

    github:set({
      icon  = { string = count > 0 and icons.bell_dot or icons.bell, color = colors.blue },
      label = { string = tostring(count) },
    })

    sbar.remove("/github.notification.*/")

    for i, notif in ipairs(notifications) do
      local repo    = (notif.repository and notif.repository.name) or "Note"
      local subj    = notif.subject or {}
      local type_   = subj.type  or ""
      local title   = subj.title or "No new notifications"
      local url_api = subj.latest_comment_url or ""

      local color = colors.blue
      local icon  = icons.git.indicator

      if type_ == "Issue" then
        color = colors.green
        icon  = icons.git.issue
      elseif type_ == "Discussion" then
        color = colors.white
        icon  = icons.git.discussion
      elseif type_ == "PullRequest" then
        color = colors.magenta
        icon  = icons.git.pull_request
      elseif type_ == "Commit" then
        color = colors.white
        icon  = icons.git.commit
      end

      if title:lower():match("deprecat") or title:lower():match("broke?") or title:lower():match("break") then
        color = colors.red
        icon  = icons.important
        github:set({ icon = { color = colors.red } })
      end

      -- Default click goes to notifications page; updated below if we can get html_url
      local notif_name = "github.notification." .. i
      local click_cmd  = "open 'https://github.com/notifications'"
        .. "; sketchybar --set github.bell popup.drawing=off"
        .. "; sleep 5; sketchybar --trigger github.update"

      sbar.add("item", notif_name, {
        position      = "popup.github.bell",
        drawing       = true,
        padding_left  = 7,
        padding_right = 7,
        background    = { corner_radius = 12 },
        icon = {
          string = icon .. " " .. repo .. ":",
          color  = color,
          background = { height = 2, y_offset = -12, color = color },
        },
        label        = { string = title },
        click_script = click_cmd,
      })

      -- Fetch the real URL for issue/PR/commit types and update the click_script
      if url_api ~= "" and (type_ == "Issue" or type_ == "PullRequest" or type_ == "Commit") then
        local captured_name = notif_name
        sbar.exec("gh api '" .. url_api .. "' | jq -r '.html_url'", function(html_url)
          html_url = html_url:gsub("%s+$", "")
          if html_url ~= "" and html_url ~= "null" then
            sbar.set(captured_name, {
              click_script = "open '" .. html_url .. "'"
                .. "; sketchybar --set github.bell popup.drawing=off"
                .. "; sleep 5; sketchybar --trigger github.update",
            })
          end
        end)
      end
    end
  end)
end

github:subscribe({"routine", "forced", "github.update"}, function(_)
  update()
end)

github:subscribe("system_woke", function(_)
  sbar.delay(10, update)
end)

github:subscribe("mouse.entered", function(_)
  github:set({ popup = { drawing = true } })
end)

github:subscribe({"mouse.exited", "mouse.exited.global"}, function(_)
  github:set({ popup = { drawing = false } })
end)

github:subscribe("mouse.clicked", function(_)
  github:set({ popup = { drawing = "toggle" } })
end)
