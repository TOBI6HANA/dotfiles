#!/usr/bin/env bash
#media-time.sh

prev=""
while :; do
    output=$(playerctl metadata --format '{{status}}||{{duration(position)}}/{{duration(mpris:length)}}    ' 2>/dev/null)
    status="${output%%||*}"
    current="${output#*||}"

    if [ -z "$output" ]; then
        current=""
    fi

    if [ "$current" != "$prev" ]; then
        echo "$current"
        prev="$current"
    fi

    if [ "$status" == "Playing" ]; then
        sleep 0.3
    else
        sleep 1
    fi
done
