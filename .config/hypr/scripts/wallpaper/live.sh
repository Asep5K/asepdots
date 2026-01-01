#!/usr/bin/env bash
set -e

# LOCK="${XDG_CACHE_HOME:-$HOME/.cache}/hypr/wallpaper_video.lock"
# exec 9>$LOCK || exit 1
# flock -n 9 || exit 0

THEME="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/themes/fullscreen-preview.rasi"
CONFIRM_THEME="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/themes/power_menu.rasi"
VIDEO_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/Wallpaper/Video"
THUMBNAIL_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/Wallpaper/Thumbnail"

if pidof rofi &>/dev/null; then
    pkill rofi
fi

choose_video(){
    mkdir -p "$THUMBNAIL_DIR"
    for a in "$VIDEO_DIR"/*; do
        THUMBNAIL="$THUMBNAIL_DIR/$(basename "$a").png"
        [ ! -f "$THUMBNAIL" ] && ffmpeg -y -i "$a" -ss 00:00:01.000 -vframes 1 "$THUMBNAIL" &>/dev/null
        echo -en "$(basename "${a%.*}")\0icon\x1f$THUMBNAIL\x00info\x1f$a\n"
    done | rofi -dmenu -p " " -format i -theme "$THEME"
}

play_video() {
    local file="$1"
    local mode="$2"

    case "$mode" in
        "With audio") mpvpaper -o "--loop" "*" "$file" & ;;
        "No audio")   mpvpaper -o "--loop --no-audio" "*" "$file" & ;;
        *) exit 0 ;;
    esac
}

selected_wallpaper=$(choose_video)

[ -z "$selected_wallpaper" ] && exit 0 

all_files=("$VIDEO_DIR"/*)

selected_path="${all_files[$selected_wallpaper]}"

# action=$(choose_mode)
action=$(printf "With audio\nNo audio" | rofi -dmenu -p " Mode" -theme "$CONFIRM_THEME")

[ -z "$action" ] && exit 0 

pkill -f swww-daemon || true

swww clear-cache &

pkill mpvpaper || true

(play_video "$selected_path" "$action" &>/dev/null & disown)
exit