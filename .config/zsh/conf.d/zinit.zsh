ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
  Aloxaf/fzf-tab \
  djui/alias-tips \
  hlissner/zsh-autopair

zinit wait'0' lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  blockf \
    zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zinit ice wait'0' lucid
zinit light joshskidmore/zsh-fzf-history-search
ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
ZSH_FZF_HISTORY_SEARCH_FZF_ARGS='--height 40% --border'
ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0

zinit ice wait'1' lucid
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::git


# vim: ft=zsh:nowrap

