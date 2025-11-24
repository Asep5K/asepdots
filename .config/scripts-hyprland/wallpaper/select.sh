#!/usr/bin/env bash
set -e

# LOCK="${XDG_CACHE_HOME:-$HOME/.cache}/hypr/wallpaper.lock"
# exec 9>"$LOCK" || exit 1
# flock -n 9 || exit 0

ROFI_THEME="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/themes/fullscreen-preview.rasi"
WALLPAPER_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/Wallpaper/Foto"
LINK="${XDG_CACHE_HOME:-$HOME/.cache}/swww/image.jpg"
FILE="$HOME/.cache/hypr/light_mode"

if pidof rofi &>/dev/null; then
    pkill rofi
fi

SELECTED=$(for a in "$WALLPAPER_DIR"/*; do
                echo -en "$(basename "${a%.*}")\0icon\x1f$a\x00info\x1f$a\n"
            done | rofi -dmenu -p " " -format i -theme "$ROFI_THEME")

[ -z "$SELECTED" ] && exit 0

ALL_FILES=("$WALLPAPER_DIR"/*)
SELECTED_PATH="${ALL_FILES[$SELECTED]}"

pidof swww-daemon || (swww-daemon & disown)

swww img "$SELECTED_PATH" \
    --transition-type any \
    --transition-step 45 \
    --transition-fps 30 \
    --transition-duration 2

ln -sf "$SELECTED_PATH" "$LINK"

if [ -f "$FILE" ]; then
    matugen -m light -t scheme-tonal-spot image "$SELECTED_PATH" 
else
    matugen -t scheme-tonal-spot image "$SELECTED_PATH" 
fi
pkill mpvpaper || true
