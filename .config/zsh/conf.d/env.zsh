# vim:ft=zsh:nowrap

typeset -U path fpath

# ======= PATH =======
path+=(
    ${XDG_DATA_HOME:-$HOME/.local/}{go,cargo}/bin
    $HOME/.npm-global/bin
    )

# ======= FPATH =======
fpath=(
    ${XDG_DATA_HOME:-$HOME/.local}/share/completions
    $fpath
)

# ======= EXPORT =======
typeset -gx SUDO_PROMPT='please type password in here!: '
typeset -gx MAKEFLAGS='-j2'
typeset -gx FZF_DEFAULT_OPTS="
    --color fg:#f8f8f2,fg+:#f8f8f2,bg+:#3e3d32
    --color hl:#f92672,hl+:#f92672,info:#ae81ff
    --color prompt:#ae81ff,spinner:#a6e22e,pointer:#66d9ef
    --color marker:#a6e22e,border:#272822,header:#f92672
    --prompt ' '
    --pointer ' '
    --layout=reverse
    --border horizontal
    --height 40%"

