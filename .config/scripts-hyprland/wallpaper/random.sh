#!/usr/bin/env bash
set -e

# LOCK="${XDG_CACHE_HOME:-$HOME/.cache}/hypr/wallpaper.lock"
# exec 9>"$LOCK" || exit 1
# flock -n 9 || exit 0

WALLPAPER_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/Wallpaper/Foto"
SELECTED="$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \) | shuf -n 1)"
LINK="${XDG_CACHE_HOME:-$HOME/.cache}/swww/image.jpg"
FILE="$HOME/.cache/hypr/light_mode"

pidof swww-daemon || (swww-daemon & disown)
swww img "$SELECTED" \
    --transition-type any \
    --transition-step 45 \
    --transition-fps 30 \
    --transition-duration 2

ln -sf "$SELECTED" "$LINK"

if [ -f "$FILE" ]; then
    matugen -m light -t scheme-tonal-spot image "$SELECTED"
else
    matugen -t scheme-tonal-spot image "$SELECTED"
fi
pkill mpvpaper || true
