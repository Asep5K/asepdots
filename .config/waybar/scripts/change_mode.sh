#!/usr/bin/env bash

FILE="$HOME/.cache/hypr/light_mode"

if [[ ! -f  "$FILE" ]]; then
    # dark mode
    touch "$FILE"
else
    # light mode
    rm -f "$FILE"
fi
