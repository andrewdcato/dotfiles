#!/bin/bash

# Companion to every move-node-to-workspace invocation (keybindings and
# on-window-detected rules). AeroSpace's exec-on-workspace-change callback
# only fires when the FOCUSED workspace changes, but move-node-to-workspace
# reassigns a window to another workspace without changing focus by default.
# That leaves sketchybar unaware a background workspace's contents changed
# until it's restarted.
#
# This talks to sketchybar directly via `--set` (bypassing a custom
# event/subscribe round trip) since a newly-declared sketchybar custom event
# reliably failed to reach its Lua subscribers here, while `--set` is the
# same primitive the existing focus-change flow already relies on.
#
# Usage: aerospace-workspace-refresh.sh <workspace-id>

WORKSPACE="$1"

SKETCHYBAR_BIN="/usr/local/bin/sketchybar"
if [ ! -f "$SKETCHYBAR_BIN" ]; then
  SKETCHYBAR_BIN="/opt/homebrew/bin/sketchybar"
fi

LUA_BIN="/usr/local/bin/lua"
if [ ! -f "$LUA_BIN" ]; then
  LUA_BIN="/opt/homebrew/bin/lua"
fi

SKETCHYBAR_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/sketchybar"

STRIP=$(
  aerospace list-windows --workspace "$WORKSPACE" \
    | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}' \
    | "$LUA_BIN" -e "
        package.path = package.path
          .. ';${SKETCHYBAR_CONFIG_DIR}/?.lua'
          .. ';${SKETCHYBAR_CONFIG_DIR}/?/init.lua'
        local icon_map = require('plugins.icon_map')
        local strip = ' '
        for line in io.lines() do
          if line ~= '' then strip = strip .. ' ' .. icon_map(line) end
        end
        io.write(strip == ' ' and ' —' or strip)
      "
)

"$SKETCHYBAR_BIN" --set "space.$WORKSPACE" label="$STRIP"

# Visibility follows the same "only manage workspaces on the focused
# monitor" rule the rest of the sketchybar config uses.
FOCUSED_MONITOR=$(aerospace list-monitors --focused | awk '{print $1}')
if aerospace list-workspaces --monitor focused | grep -qx "$WORKSPACE"; then
  if [ -n "$(aerospace list-windows --workspace "$WORKSPACE")" ]; then
    "$SKETCHYBAR_BIN" --set "space.$WORKSPACE" display="$FOCUSED_MONITOR"
  else
    "$SKETCHYBAR_BIN" --set "space.$WORKSPACE" display=0
  fi
fi
