#!/usr/bin/env bash
set -e

theme="$HOME/.config/rofi/themes/rounded-pink-dark.rasi"
XDG_HYPR_TEMP="${XDG_CONFIG_HOME:-$HOME/.config}/hypr/.temp"
XDG_HYPR_SCRIPTS="${XDG_CONFIG_HOME:-$HOME/.config}/scripts-hyprland"
GAMEMODE="$XDG_HYPR_SCRIPTS/gamemode.sh"
OP="$XDG_HYPR_SCRIPTS/utility/opacity.sh"
OPACITY="$XDG_HYPR_TEMP/opacity.conf"
CACHE=${XDG_CACHE_HOME:-$HOME/.cache}/hypr

if pgrep -x rofi; then
    pkill rofi
fi
if [[ -f "/tmp/gamemode" ]]; then
    gamemode="Gamemode [on]"
else
    gamemode="Gamemode [off]"
fi
if [[ -f "$OPACITY" ]]; then
    opacity="Opacity [on]"
else
    opacity="Opacity [off]"
fi

reload(){
    hyprctl reload &&
    hyprctl notify -1 5000 "rgb(40a02b)" "DONE"
    rm -rf "/tmp/gdk-pixbuf"* "/tmp/yazi"*
}

options="Reload hyprland\n$gamemode\n$opacity"
choice="$(echo -e "$options" | rofi -dmenu -p "Choose mode" -theme "$theme")"

case "$choice" in
    "Reload hyprland")reload;;
    "$gamemode")"$GAMEMODE";;
    "$opacity")$OP;;
esac