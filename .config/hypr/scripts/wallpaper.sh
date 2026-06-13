#!/bin/sh

WALL_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/wallpaper/images/"

export FZF_DEFAULT_OPTS="
    --color fg:#f8f8f2,fg+:#f8f8f2,bg+:#3e3d32
    --color hl:#f92672,hl+:#f92672,info:#ae81ff
    --color prompt:#ae81ff,spinner:#a6e22e,pointer:#66d9ef
    --color marker:#a6e22e,border:#66d9ef,header:#f92672
    --prompt ' '
    --pointer ' '
    --cycle
    --sync
    --preview-window=border-rounded
    --layout=reverse
    --preview-window=right:70%
"

img_path="$(cd "${WALL_DIR}" && ls | fzf --preview 'chafa --animate false --size="${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}" {}' | sed "s@^@$WALL_DIR@")"

[ -z "$img_path" ] && exit
ln -sf "$img_path" "$XDG_CONFIG_HOME/hypr/wallpaper/1.jpg"
pgrep awww-daemon >/dev/null 2>&1 || setsid awww-daemon >/dev/null 2>&1 &

exec awww img "$img_path" \
        --transition-type any \
        --transition-step 50 \
        --transition-fps 35 \
        --transition-duration 2
