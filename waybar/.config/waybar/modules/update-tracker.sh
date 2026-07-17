#!/usr/bin/env bash

treshhold_green=0
treshhold_yellow=25
treshhold_red=100

updates="$(( $(checkupdates 2>/dev/null | wc -l) + $(paru -Qua 2>/dev/null | wc -l) ))"

css_class="green"

if [ "$updates" -gt $treshhold_yellow ]; then
    css_class="yellow"
fi

if [ "$updates" -gt $treshhold_red ]; then
    css_class="red"
fi

if [ "$updates" -gt $treshhold_green ]; then
    printf '{"text": " %s", "class": "%s"}' "$updates" "$css_class"
else
    printf '{}'
fi
