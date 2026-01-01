#!/usr/bin/env bash

temp="/tmp/record"
theme="$HOME/.config/rofi/themes/power_menu.rasi"
pid_file="$temp/recorder.pid"
save_dir="${XDG_VIDEOS_DIR:-$HOME/Videos}/Recordings"
icons="/var/lib/AccountsService/icons/$USER"

# Cek apakah sedang recording
is_recording() {
    [[ -f "$pid_file" ]] && kill -0 $(cat "$pid_file") 2>/dev/null
}

# Generate filename
filename() {
    local mode="$1"
    local date="$(date +'%Y-%m-%d_%H-%M-%S')"
    echo "recording_${mode}_${date}.mp4"
}

# Notifikasi
notify() {
    local arg="$1" file="$2"
    pkill mako
    case "$arg" in
        "start") notify-send -t 2000 -i "$icons" -a "run" "⏺ Recording Started" "Press shortcut again to stop" ;;
        "stop") notify-send -t 2000 -i "$icons" -a "run" "✔ Recording Finished" "$file" ;;
        "kill") notify-send -t 2000 -i "$icons" -a "stop" "! Killing wf-recorder" "PID: $(cat "$pid_file")" ;;
    esac
}

# Stop recording
stop_recording() {
    local pid=$(cat "$pid_file")
    notify "kill"
    # Graceful stop
    kill -INT "$pid"
    
    # Tunggu max 5 detik
    if ! wait "$pid" 2>/dev/null; then
        sleep 2
        kill -KILL "$pid" 2>/dev/null
    fi
    
    # Pindahkan file
    for file in "$temp"/{*.mp4,*.mkv}; do
        if [[ -f "$file" ]]; then
            mv "$file" "$save_dir/"
            notify "stop" "$(basename "$file")"
        fi
    done
    
    # Cleanup
    rm -f "$pid_file"
    [[ -z "$(ls -A "$temp")" ]] && rm -rf "$temp"
}

# Start recording
start_recording() {
    local mode="$1"
    local audio_source="$(pactl list short sources | grep -m1 "monitor" | awk '{print $2}')"
    
    mkdir -p "$temp" "$save_dir"
    notify "start"
    
    case "$mode" in
        "audio")
            wf-recorder -a "$audio_source" -c libx264 -p preset=ultrafast -p crf=20 -D -r 30 -f "$temp/$(filename "audio")" &
            ;;
        "no_audio")
            wf-recorder -c libx264 -p preset=ultrafast -p crf=20 -D -r 30 -f "$temp/$(filename "no_audio")" &
            ;;
    esac
    
    echo $! > "$pid_file"
}

# Main function
record() {
    local mode="$1"
    
    if is_recording; then
        stop_recording
    else
        start_recording "$mode"
    fi
}

# UI atau direct command
if [[ -n "$1" ]]; then
    case "${1^^}" in
        "RECORD") record "audio" ;;
        "NO_AUDIO") record "no_audio" ;;
    esac
else
    # Rofi menu
    if is_recording; then
        choice="■ STOP RECORDING"
    else
        choice=$(echo -e "▶ RECORD + AUDIO\n▶ RECORD NO AUDIO" | rofi -dmenu -p "RECORD" ${theme:+-theme "$theme"})
    fi
    
    [[ -z "$choice" ]] && exit 1
    
    case "$choice" in
        *"+ AUDIO") record "audio" ;;
        *"NO AUDIO") record "no_audio" ;;
        *"STOP"*) stop_recording ;;
    esac
fi

