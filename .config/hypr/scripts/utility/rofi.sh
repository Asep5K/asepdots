#!/usr/bin/env bash


app=$1
thm="$HOME/.config/rofi/themes/fullscreen-preview.rasi"
dir="$HOME/.config/rofi/launchers/type-2"
theme='style-2'

function apps() {
    pkill -x rofi
    case "$app" in
        Menu)

        ## Run
            rofi -show drun -theme ${dir}/${theme}.rasi;;
        # rofi -show drun -show-icons -icon-theme Papirus >/dev/null 2>&1 ;;
        Window)
            rofi -show window -show-icons -theme "$thm" >/dev/null 2>&1 ;;
        Emoji)
            rofi -show emoji -theme ${dir}/${theme}.rasi >/dev/null 2>&1 ;;
        Clipboard)
            cliphist list | rofi -dmenu -p  "Clipboard" -theme ${dir}/${theme}.rasi | cliphist decode | wl-copy >/dev/null 2>&1 ;;
        calc)
            rofi -show calc >/dev/null 2>&1 ;;
    esac 
}

function main(){

case "$app" in
    Menu|calc|Window|Emoji|Clipboard) apps "$app" ;;
esac

}

if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    main
fi