#!/usr/bin/env bash
set -e

pid_file="/tmp/list.pid"
icons="/var/lib/AccountsService/icons/$USER"
theme="$HOME/.config/rofi/themes/power_menu.rasi"

pkill rofi || true
:> "$pid_file"

get_pid(){
    local list=(
        "foot -s"
        "foot-server"
        "footclient"
        "brave"
	    "kitty"
        "Telegram"
        "discord"
        "electron"
        "spotify"
        "code-oss"
        "wl-paste"
        "playerctl"
        "hypridle"
        "ssh-agent -s"
        "gnome-keyring"
        "yazi"
        "waybar"
        "swww-daemon"
        "hyprpaper"
    )

    for f in "${list[@]}"; do
        if pid="$(pgrep -f "$f")"; then 
            echo "$pid" >>"$pid_file"
        else
            continue
        fi
    done
}

kill_all(){
    notify-send -i "$icons" -a "run" "POWER CONTROLS" "Killing all apps & daemon"
    while read pid; do
        # Coba kill graceful dulu
        if kill "$pid" 2>/dev/null; then
            echo "Sent TERM signal to PID: $pid"
            # Tunggu maksimal 5 detik
            for i in {1..5}; do
                if ! kill -0 "$pid" 2>/dev/null; then
                    echo "PID $pid terminated gracefully"
                    break
                fi
                sleep 1
            done
            
            # Force kill jika masih hidup
            if kill -0 "$pid" 2>/dev/null; then
                kill -9 "$pid" 2>/dev/null
                echo "Force killed PID: $pid"
            fi
        else
            echo "PID $pid not found or already dead"
        fi
    done < "$pid_file"
}

is_running(){
    # cek pid running or not
    [[ -f "$pid_file" && -s "$pid_file" ]] && kill -0 $(cat "$pid_file") 2>/dev/null
}

power_options(){
    local options="$1"
    if [[ "$options" == "lock" || "$options" == "sleep" ]]; then
        pidof hypridle || (hypridle & disown)
        loginctl lock-session 
        if [[ "$options" == "sleep" ]];then
            systemctl suspend
        fi
    else
        # yes or no ?
        local answer=$(echo -e " Yes\n No" | rofi -dmenu -p "" -theme  "$theme")
            if [[ "$answer" == *"Yes" ]]; then
                get_pid
                if is_running; then
                    kill_all
                fi
                case "$options" in
                    "poweroff")systemctl poweroff;;
                    # "poweroff")echo poweroff;;
                    "reboot")systemctl reboot;;
                    "logout")hyprctl dispatch exit 0;;
                esac
            else
                return 1
            fi
    fi
}

options=" Shutdown\n Reboot\n Lock\n Sleep\n Logout"
action=$(echo -e "$options" | rofi -dmenu -p "" -theme "$theme")
[[ -z "$action" ]] && exit

case "$action" in
    *"Shutdown")power_options "poweroff";;
    *"Reboot")power_options "reboot";;
    *"Lock")power_options "lock";;
    *"Sleep")power_options "sleep";;
    *"Logout")power_options "logout";;
    *)
    if [[ -n "$action" ]]; then
        notify-send -i "$icons" "Running command" "$action"
        bash -c "$action"
    fi
    ;;
esac
