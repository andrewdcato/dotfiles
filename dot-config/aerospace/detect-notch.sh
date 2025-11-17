#!/bin/bash

# Detect if the focused monitor has a notch and adjust outer.top gap accordingly
# Strategy: Check if the display has an external connection type
# Built-in displays don't have connection type or it's not Thunderbolt/DisplayPort/HDMI

MONITOR_NAME=$(aerospace list-monitors --focused | awk -F'|' '{print $2}' | xargs)

# Get the connection type for this display
# External displays will have: "Connection Type: Thunderbolt/DisplayPort" or "HDMI" etc.
# Built-in displays either have no connection type or "Connection Type: Internal"
CONNECTION_TYPE=$(system_profiler SPDisplaysDataType 2>/dev/null | \
  awk -v monitor="$MONITOR_NAME" '
    $0 ~ monitor { found=1 }
    found && /Connection Type:/ { print $0; exit }
    found && /Displays:/ && NR > 1 { exit }
  ')

# Check if this is an external monitor
IS_EXTERNAL=false
if echo "$CONNECTION_TYPE" | grep -qE "Thunderbolt|DisplayPort|HDMI|USB"; then
  IS_EXTERNAL=true
fi

# Apply gaps based on display type
if [ "$IS_EXTERNAL" = true ]; then
  # External monitor - use standard gap
  aerospace gaps outer top 15
else
  # Built-in display - check resolution for notch
  # MacBook Pro with notch resolutions:
  # 14": 3024x1964 or 3456x2234 (native)
  # 16": 3456x2234 (native)
  RESOLUTION=$(system_profiler SPDisplaysDataType 2>/dev/null | \
    awk -v monitor="$MONITOR_NAME" '
      $0 ~ monitor { found=1 }
      found && /Resolution:/ { print $2"x"$4; exit }
    ')
  
  if [[ "$RESOLUTION" == "3024x1964" ]] || [[ "$RESOLUTION" == "3456x2234" ]]; then
    # Notched MacBook Pro
    aerospace gaps outer top 50
  else
    # Built-in but no notch
    aerospace gaps outer top 15
  fi
fi
