export BASHCONFIG="$HOME/.config/bash"
while read file; do
source "$BASHCONFIG/$file.bash"
done <<-EOF
asep
env
plugin
alias
option
prompt
EOF
