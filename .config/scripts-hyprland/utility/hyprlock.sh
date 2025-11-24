#!/usr/bin/env bash
set -euo pipefail
# shellcheck disable=SC1091

# Pastikan file os-release ada
if [[ -f /etc/os-release ]]; then
    source /etc/os-release
fi

file="/tmp/.userinfo"
: > "$file"  # kosongkan file tanpa rm

trim() {
    sed 's/^[[:space:]]*//;s/[[:space:]]*$//' <<<"$1"
}

print() {
    local name=$1 info=$2
    printf '%s %s\n' "$name" "$(trim "$info")" >> "$file"
}

get_os_age() {
    local install_date=""
    local then now days

    # 1. Ambil birth time root (umum di sistem modern)
    install_date=$(stat -c %w / 2>/dev/null || true)
    if [[ "$install_date" == "-" || -z "$install_date" ]]; then
        install_date=""
    fi

    # 2. Fallback Arch Linux
    if [[ -z "$install_date" && -f /var/log/pacman.log ]]; then
        install_date=$(awk -F'[][]' 'NR==1 {print $2}' /var/log/pacman.log | cut -d'T' -f1)
    fi

    # 3. Fallback Debian/Ubuntu
    if [[ -z "$install_date" && -d /var/log/installer ]]; then
        install_date=$(find /var/log/installer -type f -printf '%T@ %p\n' | sort -n | head -n1 | awk '{print $2}')
    fi

    # 4. Hitung umur dalam hari
    if [[ -n "$install_date" ]]; then
        then=$(date -d "${install_date%%+*}" +%s 2>/dev/null || echo 0)
        now=$(date +%s)
        days=$(( (now - then) / 86400 ))
        if (( days == 1 )); then
            echo "$days DAY"
        else
            echo "$days DAYS"
        fi
    else
        echo "UNKNOWN"
    fi
}

print_info() {
    print "USER:" "$USER"
    print "SHELL:" "$(basename "$SHELL")"
    print "OS:" "${NAME:-Unknown}"
    print "RAM:" "$(free -h | awk '/^Mem:/ {print $2}')"
    print "CPU CORES:" "$(nproc) CORE"
    print "KERNEL:" "$(uname -r)"
    print "OS AGE:" "$(get_os_age)"
    print "FIRMWARE AGE:" "$(hostnamectl | grep "Firmware Age" | sed 's/.*Firmware Age: //')"
    # print "HOSTNAME:" "$(hostname)"
    # print "UPTIME:" "$(uptime -p | sed 's/^up //')"
    # print "DAY:" "$(date +"%A, %B %d, %Y")"
}

print_info

if ! pgrep -x hyprlock >/dev/null; then
    hyprlock
fi
