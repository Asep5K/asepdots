#!/usr/bin/env bash

theme="$HOME/.config/rofi/themes/screenshot.rasi"
screenshot_directory="$HOME/Pictures/Screenshots"

screenshot() {
    local mode="$1"
    local target="$2"
    local directory="$3"
    mkdir -p "$directory"
    
    FILE="$directory/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

    if [ "$target" = "areawwh" ]; then
        grimblast save area "$FILE" && wl-copy < "$FILE"
        [ -f "$FILE" ] && notify-send -i "$FILE" -a "run" "Screenshot $mode $target" "$FILE"  -t 2000
    elif [[ "$mode" = "copy" ]] && [[ "$target" = "copy" ]]; then
        FILE="$directory/.copy.png"
        grimblast copysave screen "$FILE"
        [ -f "$FILE" ] && notify-send -i "$FILE" -a "run" "Screenshot $mode $target" -t 2000
        rm -f "$FILE"
    else
        grimblast "$mode" "$target" "$FILE"
        if [[ -f "$FILE" ]]; then
            notify-send -i "$FILE" -a "run" "Screenshot $mode $target" "$FILE" -t 2000
        else 
            notify-send -a "stop" "Screenshot failed!"
        fi
    fi
}

if [ -n "$1" ]; then
    # kalau ada argumen → langsung eksekusi tanpa rofi
    case "${1^^}" in
        "FULL") screenshot "save" "screen" "$screenshot_directory";;
        "AREA") screenshot "save" "areawwh" "$screenshot_directory/Area";;
        "WINDOW") screenshot "save" "active" "$screenshot_directory/Windowactive";;
        "CLIPBOARD") screenshot "copy" "copy" "/tmp";;
    esac

else
    # kalau nggak ada argumen → buka rofi
    pkill rofi
    options="FULL\nAREA\nWINDOW\nCLIPBOARD"
    if [ -f "$theme" ]; then
        choice=$(echo -e "$options" | rofi -dmenu -p "SCREENSHOT" -theme "$theme")
    else
        choice=$(echo -e "$options" | rofi -dmenu -p "SCREENSHOT")
    fi
    [ -z "$choice" ] && exit 0
    
    case "$choice" in
        "FULL") sleep 0.2; screenshot "save" "screen" "$screenshot_directory";;
        "AREA") sleep 0.2; screenshot "save" "areawwh" "$screenshot_directory/Area";;
        "WINDOW") sleep 0.2; screenshot "save" "active" "$screenshot_directory/Windowactive";;
        "CLIPBOARD")sleep 0.2;  screenshot "copy" "copy" "/tmp";;
    esac 
fi
