#!/bin/bash

# Detect if the focused monitor has a notch and adjust outer.top gap accordingly
# Assumes notch for displays with height > 1800 (e.g., 14" and 16" MacBook Pro)
# For notched displays, keep outer.top = 50 to maintain ~10px effective border below notch
# For non-notched, set outer.top = 10

FOCUSED_HEIGHT=$(aerospace list-monitors --focused | awk '{print $3}' | cut -d'x' -f2)

if [ "$FOCUSED_HEIGHT" -gt 1800 ]; then
  aerospace gaps outer top 50
else
  aerospace gaps outer top 15
fi
