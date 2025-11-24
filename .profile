# Environment Variables
# export EDITOR="nvim"
# export SUDO_EDITOR="$EDITOR"
# export VISUAL="$EDITOR"
export PATH="$HOME/.local/bin:$PATH"
export GPG_TTY="${TTY:-$(tty)}"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_VIDEOS_DIR="$HOME/Videos"
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_TEMPLATES_DIR="$HOME/Templates"
# export XDG_DATA_DIRS="/usr/local/share:/usr/share"
# export XDG_CONFIG_DIRS="/etc/xdg"

# optional
# [ -z "$TMPDIR" ] && export TMPDIR="/tmp"
if [ -z "${XDG_RUNTIME_DIR-}" ]; then
    XDG_RUNTIME_DIR="/run/user/$(id -u)"
fi
export XDG_RUNTIME_DIR

# go
export GOPATH="$XDG_DATA_HOME/go"

# cargo
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# autostart hyprland
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec start-hyprland 
fi


# vim: ft=sh
