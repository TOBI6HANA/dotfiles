#!/usr/bin/env bash
#window-title-bounce.sh

length=40      # visible window width
delay=0.15     # step delay while scrolling
end_pause=6    # extra ticks to pause at each end (0 to disable)

pos=0
dir=1
pause_count=0
prev_title=""

while :; do
    title=$(hyprctl activewindow -j | jq -r ".title")
    if [ "$title" = "null" ] || [ -z "$title" ]; then
        title=""
    fi

    if [ "$title" != "$prev_title" ]; then
        pos=0
        dir=1
        pause_count=0
        prev_title="$title"
    fi

    len=${#title}

    if [ "$len" -le "$length" ]; then
        echo "$title"
    else
        echo "${title:$pos:$length}"

        max_pos=$(( len - length ))

        if [ "$pause_count" -gt 0 ]; then
            pause_count=$(( pause_count - 1 ))
        else
            pos=$(( pos + dir ))

            if [ "$pos" -ge "$max_pos" ]; then
                pos=$max_pos
                dir=-1
                pause_count=$end_pause
            elif [ "$pos" -le 0 ]; then
                pos=0
                dir=1
                pause_count=$end_pause
            fi
        fi
    fi

    sleep "$delay"
done
