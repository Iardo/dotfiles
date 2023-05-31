#!/usr/bin/env bash

CLASS_WINDOW="quake"

if i3-msg -t get_tree | grep -q "\"class\":\"$CLASS_WINDOW\""; then
    i3-msg "scratchpad show" >/dev/null
    exit 0
fi

alacritty --class "$CLASS_WINDOW" -e zellij attach --create quake &
disown

for _ in $(seq 1 50); do
    if i3-msg -t get_tree | grep -q "\"class\":\"$CLASS_WINDOW\""; then
        i3-msg "scratchpad show" >/dev/null
        exit 0
    fi
    sleep 0.1
done
