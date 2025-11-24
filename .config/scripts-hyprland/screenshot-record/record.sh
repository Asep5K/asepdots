#!/usr/bin/env bash
set -e 
theme="$HOME/.config/rofi/themes/power_menu.rasi"
TMP_DIR="/tmp/record"
SAVE_DIR="$HOME/Videos/Recordings"
NORMAL_PID="$TMP_DIR/toggle_recording.pid"
NO_AUDIO_PID="$TMP_DIR/toggle_recording_no_audio.pid"
ICONS="/var/lib/AccountsService/icons/$USER"

pid_file(){
    local pid="$1"
    if [ -f "$pid" ]; then
        echo "STOP RECORDING ■"
    else
        case "$pid" in 
            "$NORMAL_PID") echo "RECORDING + AUDIO ▶";;
            "$NO_AUDIO_PID") echo "RECORDING NO AUDIO ▶";;
             *) echo "START RECORDING ▶";;
        esac
    fi
}

notify(){
    local arg="$1"
    local file="$2"
    pkill mako
    case "$arg" in
        "start")notify-send -t 2000 -i "$ICONS" "⏺ Recording started" "Press the shortcut again to stop";;
        "stop")notify-send -t 2000 -i "$ICONS" "✔ Recording finished" "$file";;
        "merging") notify-send -t 2000 -i "$ICONS" " Merging audio + video...";;
    esac
}

record_no_audio(){
    FILENAME="Recording_no_audio$(date +'%Y-%m-%d_%H-%M-%S')"
    VIDEO_FILE="$SAVE_DIR/${FILENAME}.mp4"
    if [ ! -f "$NO_AUDIO_PID" ]; then
        :> "$NO_AUDIO_PID"
        wf-recorder -c libx264 -p preset=ultrafast -p crf=23 -D -r 30 -f "$VIDEO_FILE" &
        notify "start"
    else
        if pkill wf-recorder; then
            rm -rf "$TMP_DIR"
            notify "stop" "$(basename $VIDEO_FILE)"
            echo "✔ Recording finished: $(basename $VIDEO_FILE)"
        fi
    fi
}

record() {
    # 📄 File penanda recording aktif
    FILE_INFO="$TMP_DIR/toggle_recording_files"
    FILENAME="Recording_$(date +'%Y-%m-%d_%H-%M-%S')"
    FINAL_FILE="$TMP_DIR/${FILENAME}.mp4"
    VIDEO_FILE="$TMP_DIR/recording_video_${FILENAME}.mp4"
    AUDIO_FILE="$TMP_DIR/recording_audio_${FILENAME}.wav"

    if [ ! -f "$NORMAL_PID" ]; then
        # Belum rekam → MULAI REKAM

        # 🔊 Audio dari device/output (bukan mic)
        AUDIO_SOURCE=$(pactl list short sources | grep -m1 "monitor" | awk '{print $2}')

        # Simpan path file sementara (biar bisa diakses pas stop)
        echo "$VIDEO_FILE;$AUDIO_FILE;$FINAL_FILE" > "$FILE_INFO"

        # ▶ Rekam audio di background
        parec -d "$AUDIO_SOURCE" --format=s16le --rate=48000 --channels=2 > "$AUDIO_FILE" &
        AUDIO_PID=$!

        # ▶ Rekam video di background
        wf-recorder -c libx264 -p preset=ultrafast -p crf=23 -D -r 30 -f "$VIDEO_FILE" &
        VIDEO_PID=$!

        # Simpan PID kedua proses
        echo "$VIDEO_PID:$AUDIO_PID" > "$NORMAL_PID"

        notify "start"

    else
        # Sedang rekam → HENTIKAN + GABUNG

        # Ambil PID
        IFS=":" read VIDEO_PID AUDIO_PID < "$NORMAL_PID"
        IFS=";" read VIDEO_FILE AUDIO_FILE FINAL_FILE < "$FILE_INFO"

        # Kill secara elegan
        kill "$VIDEO_PID" 2>/dev/null
        kill "$AUDIO_PID" 2>/dev/null

        # Tunggu proses selesai
        wait "$VIDEO_PID" 2>/dev/null || true
        wait "$AUDIO_PID" 2>/dev/null || true

        # Gabungin
        notify "merging"

        ffmpeg -y -i "$VIDEO_FILE" \
            -f s16le -ar 48000 -ac 2 -i "$AUDIO_FILE" \
            -c:v copy -c:a aac -af "aresample=async=1" "$FINAL_FILE"
        
        mv "$FINAL_FILE" "$SAVE_DIR" &&
        # Bersih-bersih
        rm -rf "$TMP_DIR"

        notify "stop" "$(basename $FINAL_FILE)"
        echo "✔ Recording finished: $(basename $FINAL_FILE)"
    fi
}

normal_pid="$(pid_file "$NORMAL_PID")"
no_audio_pid="$(pid_file "$NO_AUDIO_PID")"
mkdir -p "$TMP_DIR" "$SAVE_DIR"

if [ -n "$1" ];then
    case "${1^^}" in
        "RECORD")record;;
        "NO_AUDIO")record_no_audio;;
    esac
else
    options="$normal_pid\n$no_audio_pid"
    if [ -f "$theme" ]; then
        choice=$(echo -e "$options" | rofi -dmenu -p "RECORD" -theme "$theme")
    else
        choice=$(echo -e "$options" | rofi -dmenu -p "RECORD")
    fi
    [ -z "$choice" ] && exit
    
    case "$choice" in
        "$normal_pid")record;;
        "$no_audio_pid")record_no_audio;;
    esac
fi