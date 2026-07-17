#!/usr/bin/env bash

wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED; then
    swayosd-client --custom-icon microphone-sensitivity-muted-symbolic \
                    --custom-progress 0
else
    swayosd-client --custom-icon microphone-sensitivity-high-symbolic \
                    --custom-progress 1
fi
