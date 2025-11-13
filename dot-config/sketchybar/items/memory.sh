#!/bin/bash

memory_top=(
  label.font="$FONT:Semibold:7"
  label=MEM
  icon.drawing=off
  width=0
  padding_right=15
  y_offset=6
)

memory_percent=(
  label.font="$FONT:Heavy:12"
  label=MEM
  y_offset=-4
  padding_right=15
  width=55
  icon.drawing=off
  update_freq=4
  mach_helper="$HELPER"
)

memory_used=(
  width=0
  graph.color=$GREEN
  graph.fill_color=$GREEN
  label.drawing=off
  icon.drawing=off
  background.height=30
  background.drawing=on
  background.color=$TRANSPARENT
)

memory_compressed=(
  graph.color=$YELLOW
  label.drawing=off
  icon.drawing=off
  background.height=30
  background.drawing=on
  background.color=$TRANSPARENT
)

memory_bracket=()

sketchybar --add item memory.top right                    \
           --set memory.top "${memory_top[@]}"            \
                                                          \
           --add item memory.percent right                \
           --set memory.percent "${memory_percent[@]}"    \
                                                          \
           --add graph memory.used right 75               \
           --set memory.used "${memory_used[@]}"          \
                                                          \
           --add graph memory.compressed right 75         \
           --set memory.compressed "${memory_compressed[@]}"

sketchybar --add bracket memory memory.top memory.percent memory.used memory.compressed \
  --set memory "${memory_bracket[@]}"
