# zle -N _smooth_fzf
zle -N _sudo_command_line
bindkey -v

bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey -M emacs '^N' _sudo_command_line
bindkey -M vicmd '^N' _sudo_command_line
bindkey -M viins '^N' _sudo_command_line
bindkey "^?" backward-delete-char

# ====================
bindkey -s '^B' 'sudo pacman -Syu'
bindkey -s  '^F' 'zi^M'
bindkey -s '^X^Z' 'fg^M'
# bindkey '^O' _smooth_fzf
