#!/bin/bash

# This script is called by AeroSpace when workspace changes
# AeroSpace sets AEROSPACE_FOCUSED_WORKSPACE and AEROSPACE_PREV_WORKSPACE environment variables

# Query aerospace directly to get the focused workspace as a fallback
# This is useful if environment variables aren't set
FOCUSED=$(aerospace list-workspaces --focused)

# If environment variable is set, use it; otherwise use the queried value
FOCUSED_WS="${AEROSPACE_FOCUSED_WORKSPACE:-$FOCUSED}"
PREV_WS="${AEROSPACE_PREV_WORKSPACE}"

# Trigger sketchybar event with the workspace information
# Note: Variables must be on the same line as --trigger for sketchybar to pass them to scripts
# Use full path to sketchybar to handle different homebrew locations (Intel vs Apple Silicon)
SKETCHYBAR_BIN="/usr/local/bin/sketchybar"
if [ ! -f "$SKETCHYBAR_BIN" ]; then
  SKETCHYBAR_BIN="/opt/homebrew/bin/sketchybar"
fi

"$SKETCHYBAR_BIN" --trigger aerospace_workspace_change FOCUSED_WORKSPACE="$FOCUSED_WS" PREV_WORKSPACE="$PREV_WS"
