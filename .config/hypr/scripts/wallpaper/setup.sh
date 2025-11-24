#!/usr/bin/bash
set -euo pipefail

_gen_find_patterns() {
    local mode="$1"

    case "$mode" in
        -f)
			pattern=(
				'('
        		-iname '*.png'
        		-o -iname '*.jpg'
        		-o -iname '*.jpeg'
        		-o -iname '*.webp'
        		-o -iname '*.gif'
				')'
			)
            ;;
        -v)
			pattern=(
				'('
        		-iname '*.mp4'
        		-o -iname '*.mkv'
        		-o -iname '*.webm'
        		-o -iname '*.mov'
        		-o -iname '*.avi'
				')'
			)
            ;;
    esac
}

_gen_fd_pattern() {
    local mode="$1"

    case "$mode" in
        -f) echo '\.(png|jpg|jpeg|webp|gif)$' ;;
        -v) echo '\.(mp4|mkv|mov|avi|webm|jpg)$' ;;
    esac
}

gen_cache() {
    local dir mode cache
    mode="$1"
    dir="$2"
    cache="$3"

    local use_fd="no"
    if command -v fd >/dev/null 2>&1; then
        use_fd="yes"
    fi

    _find() {
        if [[ "$use_fd" = "yes" ]]; then
            local pattern
            pattern="$(_gen_fd_pattern "$mode")"
            fd --type f --max-depth 1 --regex "$pattern" "$dir"
        else
            find "$dir" -maxdepth 1 -type f $(_gen_find_patterns "$mode")

        fi
    }

    local total total_cache

    total="$(_find | wc -l)"

    if [[ -f "$cache" ]]; then
        total_cache="$(wc -l < "$cache" 2>/dev/null || echo 0)"
    else
        total_cache=0
    fi

    if [[ ! -f "$cache" ]] || [[ "$total_cache" -ne "$total" ]] || [[ ! -s "$cache" ]]; then
        echo "Updating cache..." >&2
        _find | sort > "$cache"
    fi
	return
}

wallpaper_selection() {
	local theme file wall_dir selected matches list icon_name

	file="$1"
	wall_dir="$2"
    theme="fullscreen-preview.rasi"

	pkill rofi 2>/dev/null || true

    selected="$(
		while IFS= read -r list; do
    		icon_name="${list##*/}"
    		echo -en "${icon_name%.*}\0icon\x1fthumbnail://$list\n"
    	done < "${file}" | rofi -dmenu -show-icons -p "" -theme "${theme}"
		)"

	[ -z "$selected" ] && exit 0

	matches=( "$wall_dir/$selected."* )

	if [[ -e "${matches[0]}" ]]; then
		echo "${matches[0]}"
		# notify-send -i "${matches[0]}" "wallpaper changed"
	    return 0
    else
        echo "Error: File not found: $selected" >&2
        notify-send "Error: File not found: $selected" >&2
        return 1
	fi
}

# vim:ft=sh:nowrap
