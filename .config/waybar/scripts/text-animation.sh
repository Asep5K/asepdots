#!/usr/bin/env bash

# text.sh

# ref: https://github.com/Mon4sm/monasm-dots/blob/main/.config/hypr/scripts/text_animation/anitext.sh

function get_os_age() {
    install_date=$(awk -F'[][]' 'NR==1 {print $2}' /var/log/pacman.log | cut -d'T' -f1)
    then=$(date -d "${install_date%%+*}" +%s 2>/dev/null || echo 0)
    now=$(date +%s)
    days=$(((now - then) / 86400))
    echo "$days DAYS"
}

# " 󰣇    󰮤       "
messages=(
    "🫵😂 archinstall 🤓🤓"
    "I dont know LoL"
    "Hello ${USER^^}"
    "Howdy my Sigma!"
    "Consider taking a bath?"
    "I use Arch BTW"
    "Arch is so GOATed UwU"
    "VScode > Neovim FrFr"
    "Skill Issue"
)

# optional
messages+=(
    # "$(hyprctl splash)"
    # "Init: $(cut -d ' ' -f 1 /proc/1/comm)"
    # "Shell: $(basename $SHELL)"
    # "Packages: pacman $(pacman -Q | wc -l)"
    # "Ram: $(free -h | grep 'Mem:' | awk '{print $2}')"
    # "Wm: $XDG_CURRENT_DESKTOP"
    # "Os: $(awk -F '"' '/PRETTY_NAME/ { print $2 }' /etc/os-release)"
    # "Os age: $(get_os_age)"
    # "Ram: $(free -h | grep 'Mem:' | awk '{print $2}')"
    # "$(lscpu | grep 'Model name:'| awk '{gsub(/Model name:/, "Cpu: "); $1=$1};1')"
    # "Vga: $(lspci | grep 'VGA' | cut -d ':' -f3)"
    # "Kernel: $(uname -r)"
    # "$(uptime -p | sed s'/up/Uptime:/')"
    # "$(hostnamectl | grep 'Firmware Age:'| sed 's/^[[:space:]]*//')"
)

output_file="/tmp/typing_animation.txt"

cleanup() {
    rm -f "$output_file"
    exit 0
}

trap cleanup EXIT INT TERM

current_message_index=0

while [ $current_message_index -lt ${#messages[@]} ]; do

    current_text=""
    current_message="${messages[$current_message_index]}"
    message_length=${#current_message}

    # Typing effect - add characters one by one
    for ((char_position = 0; char_position < message_length; char_position++)); do
        current_text+="${current_message:$char_position:1}"
        # echo "$current_text"
        echo "{\"text\": \"$current_text\",\"tooltip\": \"$current_text\", \"alt\": \"write\",\"class\": \"write\"}"
        # echo "$current_text" > "$output_file"
        sleep 0.2 # Typing speed
    done

    sleep 5 # Pause with full message displayed

    # Deleting effect - remove characters one by one
    for ((char_position = message_length - 1; char_position >= 0; char_position--)); do
        current_text="${current_text:0:$char_position}"
        echo "{\"text\": \"$current_text\", \"tooltip\": \"$current_text\", \"alt\": \"delete\",\"class\": \"delete\"}"
        # echo "$current_text"
        # echo "$current_text" > "$output_file"
        sleep 0.1 # Faster deletion
    done

    # Move to next message
    current_message_index=$((current_message_index + 1))
    # Reset to first message if we've shown all
    if [ $current_message_index -eq ${#messages[@]} ]; then
        current_message_index=0
    fi
done
