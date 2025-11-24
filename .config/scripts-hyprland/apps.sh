#!/usr/bin/env bash
app=$1
thm="$HOME/.config/rofi/themes/fullscreen-preview.rasi"

apps() {
    pkill -x rofi
    case "$app" in
        Menu)
        rofi -show drun -show-icons -icon-theme Papirus >/dev/null 2>&1 ;;
        Window)
        rofi -show window -show-icons -theme "$thm" >/dev/null 2>&1 ;;
        Emoji)
        rofi -show emoji >/dev/null 2>&1 ;;
        Clipboard)
        cliphist list | rofi -dmenu -p  "Clipboard" | cliphist decode | wl-copy >/dev/null 2>&1 ;;
        calc)
        rofi -show calc >/dev/null 2>&1 ;;
    esac 
}
case "$app" in
    Menu|calc|Window|Emoji|Clipboard) apps "$app" ;;
esac
