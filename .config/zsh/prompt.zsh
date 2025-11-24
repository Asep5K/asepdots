##
## Prompt
##

# Load starship
# zinit ice as'command' from'gh-r' \
#   atload'export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml; eval $(starship init zsh)' \
#   atclone'./starship init zsh > init.zsh; ./starship completions zsh > _starship' \
#   atpull'%atclone' src'init.zsh'
# zinit light starship/starship

if command -v starship >/dev/null; then 
    export STARSHIP_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/starship/starship_zsh.toml"
    eval "$(starship init zsh)"
    eval "$(starship completions zsh)"
fi

# vim:ft=zsh
