# ░░ Environment Variables ░░
export GPG_TTY="${TTY:-$(tty)}"
export TERMINAL="foot"
export BROWSER="brave"
export VISUAL="nvim"
export EDITOR="nvim"
export XIVIEWER="swayimg"
export XDG_CONFIG_DIRS="/etc/xdg"
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
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"

# ░░ SSH Agent Setup ░░
pgrep -u $USER ssh-agent || eval "$(ssh-agent -s)"
if ! ssh-add -l >&/dev/null && [[ -f "$HOME/.ssh/id_rsa" ]]; then
    ssh-add -q "$HOME/.ssh/id_rsa"
fi

# ░░ Optional: Start WM on tty1 (uncomment jika perlu) ░░
# if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
#     exec Hyprland
# fi
