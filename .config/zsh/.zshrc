while read file; do
source "$ZDOTDIR/$file.zsh"
done <<-EOF
env
asep
plugins
prompt
options
alias
utility
keybinds
EOF
