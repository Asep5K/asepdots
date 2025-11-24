#!/usr/bin/env bash
line="$1"
export PATH="$HOME/.config/scripts-hyprland/bin:$PATH"
preview="/tmp/preview.png"

# requirements grim-hyprland-git  
IFS=$'\t' read -r addr _ <<< "$line"
dim=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}

grim -t png -l 0 -w "$addr" "$preview"
chafa --animate false -s "$dim" "$preview"
