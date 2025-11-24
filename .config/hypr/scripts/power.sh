#!/usr/bin/bash
set -e

pid_file="$(mktemp)"
icons="$HOME/.face"
theme="style-6"

pkill rofi || true

trap 'rm -f $pid_file' EXIT

get_pid() {
    local arr=(
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
        "awww-daemon"
        "hyprpaper"
    )

    for f in "${arr[@]}"; do
        if ! pid="$(pgrep -f "$f")"; then
            continue
        fi
        echo "$pid" >>"$pid_file"
    done
}

get_pid &

kill_all() {
    notify-send -i "$icons" -a "run" "POWER CONTROLS" "Killing all apps & daemon"
    while read -r pid; do
        # Coba kill graceful dulu
        if kill "$pid" 2>/dev/null; then
            echo "Sent TERM signal to PID: $pid"
            # Tunggu maksimal 5 detik
            for _ in {1..5}; do
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
    done <"$pid_file"
}

is_running() {
    # cek pid running or not
    [[ -f "$pid_file" && -s "$pid_file" ]] && kill -0 "$(cat "$pid_file")" 2>/dev/null
}

power_options() {
    local options="$1"
    if [[ "$options" == "lock" || "$options" == "sleep" ]]; then
        pidof hypridle || { hypridle & disown; }
        loginctl lock-session
        if [[ "$options" == "sleep" ]]; then
            systemctl suspend
        fi
    else
        # yes or no ?
        local choice="<span color='green'>Continue $options</span>\0icon\x1f<span color='green'></span>\n<span color='red'>Cancel $options</span>\0icon\x1f<span color='red'></span>"
        answer="$(echo -en "$choice" | rofi -dmenu -markup-rows -p "$options" -theme "${theme}")" #
        if [[ "$answer" == *"Continue $options"* ]]; then
            if is_running; then
                kill_all
            fi
            case "$options" in
                *"poweroff"*) systemctl poweroff ;;
                *"reboot"*) systemctl reboot ;;
                *"logout"*) hyprctl dispatch 'hl.dsp.exit()' ;;
            esac
        else
            return 1
        fi
    fi
}


options=$(cat <<-EOF
<span color='red'>Shutdown</span>\0icon\x1f<span color='red'>⏻</span>
<span color='red'>Reboot</span>\0icon\x1f<span color='red'>↻</span>
<span color='magenta'>Lock</span>\0icon\x1f<span color='magenta'></span>
<span color='brown'>Sleep</span>\0icon\x1f<span color='brown'>󰒲</span>
<span color='orange'>Logout</span>\0icon\x1f<span color='orange'>󰈆</span>
EOF
)

action="${1:-"$(echo -en "$options" | rofi -dmenu -markup-rows -p "Choose mode:" -theme ${theme})"}"

[ -z "$action" ] && exit

case "${action^^}" in
    *"SHUTDOWN"*) power_options "poweroff" ;;
    *"REBOOT"*) power_options "reboot" ;;
    *"LOCK"*) power_options "lock" ;;
    *"SLEEP"*) power_options "sleep" ;;
    *"LOGOUT"*) power_options "logout" ;;
    *) exit ;;
esac
