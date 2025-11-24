#!/usr/bin/bash

set -euo pipefail

pkill rofi || true
video_dir="${XDG_DATA_HOME:-$HOME/.local/share}/wallpaper/videos"
cache="$HOME/.cache/awww/videos.txt"
log="/tmp/mpvpaper.log"
pid="/tmp/mpvpaper.pid"
. "$HOME/.config/hypr/scripts/wallpaper/setup.sh"

gen_cache -v "$video_dir" "$cache"

kill_mpvpaper(){
    kill -INT $(< "$pid")
}

play_video() {
    local file="$1"
    local mode="$2"

    case "$mode" in
        "With"*) opts='--loop' ;;
        "No"*) opts='--loop --no-audio' ;;
        "Kill"*) kill_mpvpaper;exit ;;
        *) exit 0 ;;
    esac
    mpvpaper ALL --auto-pause -o "$opts" "$file" &
}

selected_path="$(wallpaper_selection "$cache" "$video_dir")"
filename="${selected_path##*/}"
if [[ "${filename%.}" =~ 'kill' ]]; then
    nohup awww-daemon >/dev/null 2>&1 &
    kill_mpvpaper;exit
fi

opts="With audio\0icon\x1f<span color='red'></span>\n\
No audio\0icon\x1f<span color='cyan'></span>\n\
Kill mpvpaper\0icon\x1f<span color='red'></span>"

[ -z "$selected_path" ] && exit 0

action=$(echo -e "$opts" | rofi -dmenu -p " Mode" -theme)

kill_mpvpaper || true
awww kill || true

play_video "$selected_path" "$action" >"$log" 2>&1
echo $! > "$pid"
exit
