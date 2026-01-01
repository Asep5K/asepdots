#!/usr/bin/env sh

set -e
gamemode_on="$XDG_CACHE_HOME/gamemode.on"

function gamemode(){
list_kill=(
    swww-daemon
    waybar
    playerctl
)

HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ] ; then
    for f in "${list_kill[@]}"; do
        pkill "$f" || true
    done
    hyprctl --batch " 
    keyword animations:enabled 0;\
    keyword animation borderangle,0;\
    keyword decoration:shadow:enabled 0;\
    keyword decoration:blur:enabled 0;\
	keyword decoration:fullscreen_opacity 1;\
    keyword general:gaps_in 0;\
    keyword general:gaps_out 0;\
    keyword general:border_size 1;\
    keyword decoration:rounding 0"
    hyprctl notify 1 5000 "rgb(40a02b)" "Gamemode [ON]"
    :> $gamemode_on
    exit 
else
    rm -f $gamemode_on || true
    hyprctl notify 1 5000 "rgb(d20f39)" "Gamemode [OFF]"
    hyprctl reload
    pidof swww-daemon || (swww-daemon & disown)
    exit 
fi
}


if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    Script di-run langsung
    gamemode
fi