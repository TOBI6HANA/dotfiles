#!/bin/bash

# start daemon first
DAEMON_PID=$!

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
INTERVAL=300

while true; do
    WALL=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" \) | shuf -n 1)

    awww img $WALL --transition-type random --transition-duration 1.5

    sleep "$INTERVAL"
done
