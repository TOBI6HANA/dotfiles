#!/usr/bin/env bash

paru -Syu

echo
echo "Update complete."
pkill -RTMIN+8 waybar
read -rp "Press Enter to exit..."

