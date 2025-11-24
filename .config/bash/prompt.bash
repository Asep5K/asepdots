Black="\033[30m"
Blue="\033[34m"
Cyan="\033[36m"
Green="\033[32m"
Magenta="\033[35m"
Red="\033[31m"
White="\033[37m"
Yellow="\033[33m"

# \d -Current date
# \e - Escape character
# \h - Hostname
# \n - Newline
# \t - Current time 24-hour HH:MM:SS
# \T - 12-hour HH:MM:SS
# \@ - 12-hour HH:MM am/pm
# \u - Username of current user
# \w - Path to current working directory

# PS1="\[\e[32m\]\u \[\e[34m\]\[\e[m\]  "
# PS1="\w\n$Cyan $Magenta$White "
unset color_prompt force_color_prompt 
if command -v starship >/dev/null; then
    completions="${XDG_CACHE_HOME:-$HOME/.cache}/starship/bash_completions"
    export STARSHIP_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/starship/starship_bash.toml"
    eval "$(starship init bash)"
    if [ -f $completions ]; then
        source "$completions"
    else
        mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/starship"
        starship completions bash > "$completions"
        source "$completions"
    fi

fi
