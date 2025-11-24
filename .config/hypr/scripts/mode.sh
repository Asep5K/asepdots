#!/bin/bash


theme='style-6.rasi'

status(){
  local apps="$1" show="${2:-$apps}"
  if pid="$(pidof "$apps")" &>/dev/null; then
    printf '%s %s\n' "$show" "[$pid]"

  else
    printf '%s\n' "[off]"
  fi
}


options="set opacity
reload
"

choice=$(printf '%s' "$options" | rofi -dmenu -p "kontol" -theme "$theme"  )

printf "$choice"


case "$choice" in
  *opacity) hyprctl eval "hl.window_rule({ match = { class = 'footclient'}, opacity = 0.8})";;
  reload) hyprctl reload ;;
esac



