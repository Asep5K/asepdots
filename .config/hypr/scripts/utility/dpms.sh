#!/usr/bin/env bash

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/hypr"
LOCK="$CACHE_DIR/dpms.lock"
FILE="$CACHE_DIR/dpms_on"
mkdir -p "$CACHE_DIR"

exec 9>"$LOCK" || exit 1
flock -n 9 || exit 0

daemon(){
    services=("waybar" "hypridle" "swww-daemon")
    if [[ "$1" == "on" ]]; then
        for f in "${services[@]}"; do
            if ! pgrep -f "$f" &>/dev/null; then
                "$f" &>/dev/null & disown
            fi
        done
    else
        for f in "${services[@]}"; do
            pkill -f "$f" &>/dev/null
        done
    fi
}

lock(){
    if pidof hypridle; then
	loginctl lock-session
    else
	hypridle &
	loginctl lock-session
    fi	
}


if [[ -f "$FILE" ]]; then
    rm -f "$FILE" "$LOCK"
    daemon "on"
    brightnessctl -r
    hyprctl dispatch dpms on
else
    :> "$FILE"
    lock
    hyprctl dispatch dpms off
    brightnessctl -s set 5
    daemon "off"
fi
exit 0
