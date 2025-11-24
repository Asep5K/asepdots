umask 022
autoload -Uz compinit

if [[ -n ${ZCOMPDUMP}(#qN.m-1) ]]; then
  compinit -C
else
  compinit
fi

# ======= Configuration =======
if test -d $ZDOTDIR/conf.d/; then
    for f in $ZDOTDIR/conf.d/*.zsh; do
        . "$f"
    done
fi

# ======= Private =======
test -f "$ZDOTDIR/.env" && . "$ZDOTDIR/.env"

# ======= History =======
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh_history"
HISTSIZE=10000
SAVEHIST=10000
HISTDUP=erase
HIST_STAMPS="mm/dd/yyyy"

# ======= Autosuggestion =======
ZSH_AUTOSUGGEST_USE_ASYNC="true"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets root)
ZSH_HIGHLIGHT_MAXLENGTH=512
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#94E2D5,bold"

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# ===== Utility =====
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# Pkgfile
(( $+commands[pkgfile] )) && . '/usr/share/doc/pkgfile/command-not-found.zsh'

# ilangin warna pas paste
zle_highlight=(paste:none)

