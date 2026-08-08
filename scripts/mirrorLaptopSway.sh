#!/bin/sh
set -e
TARGET_OUTPUT="${1:-}"
MODE="${2:-1920x1080}"

usage() { 
  echo "Usage: $0 <target-output> [resolution]" >&2 
  echo "Example: $0 HDMI-A-1 1920x1080" >&2 echo "Find outputs with: swaymsg -t get_outputs" >&2 
} 

if [ -z "$TARGET_OUTPUT" ]; then 
  usage
  exit 1
fi

swaymsg output eDP-1 mode $MODE
swaymsg output $TARGET_OUTPUT mode $MODE
wl-mirror --fullscreen-output $TARGET_OUTPUT eDP-1
