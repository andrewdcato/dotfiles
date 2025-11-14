#!/bin/bash

# This script is called by AeroSpace when workspace changes
# AeroSpace sets AEROSPACE_FOCUSED_WORKSPACE and AEROSPACE_PREV_WORKSPACE environment variables

# Trigger sketchybar event with the workspace information
sketchybar --trigger aerospace_workspace_change \
  AEROSPACE_FOCUSED_WORKSPACE="$AEROSPACE_FOCUSED_WORKSPACE" \
  AEROSPACE_PREV_WORKSPACE="$AEROSPACE_PREV_WORKSPACE"
