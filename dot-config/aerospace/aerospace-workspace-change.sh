#!/bin/bash

# Wrapper script for aerospace workspace change events
# This allows us to use environment variables instead of hardcoded paths

# Get the config directory, fallback to ~/.config if XDG_CONFIG_HOME is not set
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

# Execute the sketchybar aerospace event handler
"$CONFIG_DIR/sketchybar/plugins/aerospace_event.sh"
