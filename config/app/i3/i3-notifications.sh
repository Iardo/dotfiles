#!/usr/bin/env bash

CLASS_WINDOW="notifications"

pick() {
    local lines selected_id
    lines=$(dunstctl history | jq -r '
      .data[0][]
      | [(.id.data | tostring),
         (.summary.data + " - " + (.body.data | gsub("\n"; " ")))]
      | @tsv' | sed -E 's/<[^>]*>//g')
    [ -z "$lines" ] && exit 0

    selected_id=$(fzf --delimiter '\t' --with-nth 2.. --prompt 'Notificaciones > ' --border sharp \
        --color 'bg:#000000,bg+:#000000,fg:#999999,fg+:#b8ff3d,hl:#b8ff3d,hl+:#b8ff3d,prompt:#b8ff3d,pointer:#b8ff3d,info:#4c4c4c,border:#FFC107' \
        <<<"$lines" | cut -f1)
    [ -n "$selected_id" ] && dunstctl history-pop "$selected_id"
}

if [ "$1" = "--pick" ]; then
    pick
    exit 0
fi

if i3-msg -t get_tree | grep -q "\"class\":\"$CLASS_WINDOW\""; then
    i3-msg "[class=\"^$CLASS_WINDOW\$\"] kill" >/dev/null
    exit 0
fi
exec alacritty --class "$CLASS_WINDOW" -e "$0" --pick
