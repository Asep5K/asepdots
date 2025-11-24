#!/usr/bin/bash

lock_dir="/run/user/$(id -u)/spotify_notify"
mkdir -p "$lock_dir"

lock=$lock_dir/spotify_notify.lock
exec 9>"$lock" || exit 1

if ! flock -n 9; then
    echo "Script already running" >&2
    exit 0
fi

trap 'flock -u 9; rm -rf "$cache_dir"' EXIT INT TERM

notify() {
    local icon="$1"
    local text1="$2"
    local text2="$3"
    notify-send --icon="$icon" \
        --app-icon=spotify \
        --app-name="spotify" \
        --expire-time=5 \
        "$text1" \
        "$text2"
}

# pidof playerctld >/dev/null 2>&1 || nohup playerctld daemon >/tmp/playerctld.log 2>&1 &

playerctl --player=spotify metadata --follow \
    --format '{{mpris:trackid}}|{{artist}}|{{title}}|{{mpris:artUrl}}' |
    while IFS='|' read -r id artist title arturl; do
        [ -z "$title" ] && continue

        cache="$lock_dir/spotify-last-id"
        last=$(cat "$cache" 2>/dev/null)

        [ "$id" = "$last" ] && continue
        echo "$id" >"$cache"

        # cover="$lock_dir/spotify-cover.png"

        # curl -sL "$arturl" -o "$cover" && \
        notify "$cover" "$artist" "$title"
    done
