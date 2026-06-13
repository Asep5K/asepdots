#!/usr/bin/bash

# OTIMIZED  VERSION

set -euo pipefail

wallpaper_dir="${XDG_DATA_HOME:-$HOME/.local/share}/wallpaper/images"
cache="$HOME/.cache/awww/images.txt"
# shellcheck disable=SC1091
. "$HOME/.config/hypr/scripts/wallpaper/setup.sh"

show_help() {
	local f="${0##*/}"
	cat <<-EOF
		Wallpaper Manager for Hyprland

		Usage: $f [OPTION] [INTERVAL]

		Options:
		  -d, --daemon    Run as daemon, change wallpaper at specified interval (seconds)
		  -s, --select    Interactive wallpaper selection using rofi menu
		  -r, --random    Set a random wallpaper immediately
		  -h, --help      Display this help message
		  -rc, --rmcache  Remove $cache

		Examples:
		  Interactive selection:  $f -s
		  Random wallpaper:       $f -r
		  Daemon mode:            $f -d
		  Daemon mode (10 min):   $f -d 600

		Note:
		  Default interval for daemon mode is 300 seconds (5 minutes)
	EOF
}

gen_cache -f "$wallpaper_dir" "$cache"

random_image() {
	local count
	count=$(wc -l <"$cache" 2>/dev/null || echo 0)
	((count == 0)) && return 1

	local random_line=$((RANDOM % count + 1))
	sed -n "${random_line}p" "$cache"
}

set_wallpaper() {
	local opts="$1" selected
	local link="$HOME/.config/hypr/wallpaper/1.jpg"
	case $opts in
	-r | --random) selected="$(random_image)" ;;
	-s | --select) selected="$(wallpaper_selection "$cache" "$wallpaper_dir")" ;;
	esac

	pidof awww-daemon >/dev/null 2>&1 || nohup awww-daemon >/tmp/swww-daemon.log 2>&1 &
	# wal -s -e -i "$selected" --out-dir "${XDG_CONFIG_HOME:-$HOME/.config}/colors"

	awww img "$selected" \
		--transition-type any \
		--transition-step 50 \
		--transition-fps 35 \
		--transition-duration 2

	[ "${selected##*.}" != "gif" ] && ln -f "$selected" "$link"

	pkill hyprpaper || true
	pkill mpvpaper || true
}

daemon() {
	local interval="${1:-300}"
	while true; do
		set_wallpaper -r
		sleep "$interval"
	done
}

main() {
	local i="${2-}"
	case "${1-}" in
	-r | --random) set_wallpaper -r ;;
	-s | --select) set_wallpaper -s ;;
	-d | --daemon) daemon "$i" ;;
	-rc | --rmcache) rm -f "$cache" ;;
	-h | --help | *) show_help ;;
	esac
	exit

}

if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
	main "$@"
fi
