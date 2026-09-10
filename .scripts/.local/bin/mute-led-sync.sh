#!/bin/bash
LED=/sys/class/leds/input12::mute/brightness

sync_led() {
  if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED; then
    echo 1 > "$LED"
  else
    echo 0 > "$LED"
  fi
}

sync_led
pw-mon | while read -r line; do
  sync_led
done
