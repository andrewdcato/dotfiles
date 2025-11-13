#!/bin/bash


if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.color=0x88FF00FF label.shadow.drawing=on icon.shadow.drawing=on background.border_width=2
else
  sketchybar --set $NAME background.color=0x44FFFFFF label.shadow.drawing=off icon.shadow.drawing=off background.border_width=0
fi

# window_state() {
#   source "$CONFIG_DIR/colors.sh"
#   source "$CONFIG_DIR/icons.sh"
#
#   # Get the focused window's ID
#   FOCUSED_WINDOW=$(aerospace list-windows --focused)
#
#   if [ -z "$FOCUSED_WINDOW" ]; then
#     # No window focused, hide the item
#     sketchybar -m --set $NAME icon.width=0 label.width=0
#     return
#   fi
#
#   # Extract floating status from aerospace
#   # aerospace doesn't have native JSON output, so we parse the window info
#   WINDOW_INFO=$(aerospace list-windows --focused)
#
#   COLOR=$BAR_BORDER_COLOR
#   ICON=""
#
#   # Check if the window is floating
#   if echo "$WINDOW_INFO" | grep -q "\[floating\]"; then
#     ICON=$AEROSPACE_FLOAT
#     COLOR=$RED
#   else
#     # Window is tiled
#     ICON=$AEROSPACE_TILED
#     COLOR=$GREEN
#   fi
#
#   args=(--bar border_color=$COLOR --animate sin 10 --set $NAME icon.color=$COLOR)
#
#   [ -z "$ICON" ] && args+=(icon.width=0) \
#                 || args+=(icon="$ICON" icon.width=30)
#
#   sketchybar -m "${args[@]}"
# }
#
#
# mouse_clicked() {
#   # Toggle floating for the focused window
#   aerospace layout floating
#   sleep 0.1
#   aerospace layout tiling
#   window_state
# }
#
# case "$SENDER" in
#   "mouse.clicked") mouse_clicked
#   ;;
#   "space_change") window_state
#   ;;
#   "window_focus") window_state
#   ;;
# esac
