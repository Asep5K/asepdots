#!/usr/bin/env sh
set -e

theme="$XDG_CONFIG_HOME/rofi/launchers/type-6/style-6.rasi"
source "$HYPRSCRIPTS/utility/gamemode.sh"
source "$HYPRSCRIPTS/utility/opacity.sh"


pkill rofi || true


function status(){
    local apps show

    apps="$1"
    show="${2:-$apps}"

    if pid=$(pidof "$apps") &>/dev/null || [[ -f "$apps" ]]; then
        pid="${pid:-12345}"
        echo "$show [pid:$pid] [on]"
    else 
        echo "$show [off]"
    fi

}


function toggle(){
    local apps="$1"
    if pgrep -f "$apps" &>/dev/null; then
        pkill "$apps" &>/dev/null
    else
        ("$apps" & disown)
    fi
}


function reload(){
    hyprctl reload &&
    hyprctl notify -1 5000 "rgb(40a02b)" "DONE"
    rm -f "$gamemode_on"
    # rm -rf "/tmp/gdk-pixbuf"* "/tmp/yazi"* # DANGEROUS
}


foot_server="$(status foot 'foot server')"
waybar="$(status waybar)"
hypridle="$(status hypridle)"
opacity="$(status $opacity_conf opacity)"
gamemode="$(status $gamemode_on gamemode)"
swww_daemon="$(status swww-daemon wallpaper)"


options="Reload Hyprland\n\
$gamemode\n\
$opacity\n\
$foot_server\n\
$waybar\n\
$hypridle\n\
$swww_daemon"

choice="$(echo -e "$options" | rofi -dmenu -p "Choose mode" -theme "$theme")"

case "$choice" in
    "Reload Hyprland") reload;;
    "$gamemode") gamemode;;
    "$opacity") set_opacity;;
    "$waybar") toggle "waybar";;
    "$hypridle") toggle "hypridle";;
    "$foot_server") toggle "foot";;
    "$swww_daemon") toggle "swww-daemon";;
    *) [[ -n "$choice" ]] && notify-send "$choice";;
esac