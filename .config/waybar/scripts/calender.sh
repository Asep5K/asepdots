
calendar() {
LOCK_FILE="$HOME/.cache/eww-calendar.lock"

run() {
    eww open calender
}

# Open widgets
if [[ ! -f "$LOCK_FILE" ]]; then
    touch "$LOCK_FILE"
    run && echo "ok good!"
else
    eww close calender
    rm "$LOCK_FILE" && echo "closed"
fi
}

[ -z "$1" ] && exit 0
if [ "$1" = "calender" ]; then
    calendar
fi