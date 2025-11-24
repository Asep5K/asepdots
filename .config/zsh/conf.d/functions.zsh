#function _smooth_fzf(){
#     local fname current_dir="$PWD"
#     cd "${XDG_CONFIG_HOME:-$HOME/.config}"
#     fname="$(fzf)" || cd "$current_dir"
#     "${=EDITOR:-vim}" "$fname"
#     cd "$current_dir" || return
# }


function _sudo_replace_buffer(){
    local old=$1 new=$2 space=${2:+ }

    # if the cursor is positioned in the $old part of the text, make
    # the substitution and leave the cursor after the $new text
    if [[ $CURSOR -le ${#old} ]]; then
        BUFFER="${new}${space}${BUFFER#$old }"
        CURSOR=${#new}
    # otherwise just replace $old with $new in the text before the cursor
    else
        LBUFFER="${new}${space}${LBUFFER#$old }"
    fi
}


function _sudo_command_line(){
    # If line is empty, get the last run command from history
    [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"

    # Save beginning space
    local WHITESPACE=""
    if [[ ${LBUFFER:0:1} = " " ]]; then
        WHITESPACE=" "
        LBUFFER="${LBUFFER:1}"
    fi

    {
    # If $SUDO_EDITOR or $VISUAL are defined, then use that as $EDITOR
    # Else use the default $EDITOR
    local EDITOR=${SUDO_EDITOR:-${VISUAL:-$EDITOR}}

    # If $EDITOR is not set, just toggle the sudo prefix on and off
    if [[ -z "$EDITOR" ]]; then
        case "$BUFFER" in
            sudo\ -e\ *) _sudo_replace_buffer "sudo -e" "" ;;
            sudo\ *) _sudo_replace_buffer "sudo" "" ;;
            *) LBUFFER="sudo $LBUFFER" ;;
        esac
        return
    fi

    # Check if the typed command is really an alias to $EDITOR

    # Get the first part of the typed command
    local cmd="${${(Az)BUFFER}[1]}"
    # Get the first part of the alias of the same name as $cmd, or $cmd if no alias matches
    local realcmd="${${(Az)aliases[$cmd]}[1]:-$cmd}"
    # Get the first part of the $EDITOR command ($EDITOR may have arguments after it)
    local editorcmd="${${(Az)EDITOR}[1]}"

    # Note: ${var:c} makes a $PATH search and expands $var to the full path
    # The if condition is met when:
    # - $realcmd is '$EDITOR'
    # - $realcmd is "cmd" and $EDITOR is "cmd"
    # - $realcmd is "cmd" and $EDITOR is "cmd --with --arguments"
    # - $realcmd is "/path/to/cmd" and $EDITOR is "cmd"
    # - $realcmd is "/path/to/cmd" and $EDITOR is "/path/to/cmd"
    # or
    # - $realcmd is "cmd" and $EDITOR is "cmd"
    # - $realcmd is "cmd" and $EDITOR is "/path/to/cmd"
    # or
    # - $realcmd is "cmd" and $EDITOR is /alternative/path/to/cmd that appears in $PATH
    if [[ "$realcmd" = (\$EDITOR|$editorcmd|${editorcmd:c}) \
        || "${realcmd:c}" = ($editorcmd|${editorcmd:c}) ]] \
        || builtin which -a "$realcmd" | command grep -Fx -q "$editorcmd"; then
        _sudo_replace_buffer "$cmd" "sudo -e"
        return
    fi

    # Check for editor commands in the typed command and replace accordingly
    case "$BUFFER" in
      $editorcmd\ *) _sudo_replace_buffer "$editorcmd" "sudo -e" ;;
      \$EDITOR\ *) _sudo_replace_buffer '$EDITOR' "sudo -e" ;;
      sudo\ -e\ *) _sudo_replace_buffer "sudo -e" "$EDITOR" ;;
      sudo\ *) _sudo_replace_buffer "sudo" "" ;;
      *) LBUFFER="sudo $LBUFFER" ;;
    esac
    } always {
    # Preserve beginning space
    LBUFFER="${WHITESPACE}${LBUFFER}"

    # Redisplay edit buffer (compatibility with zsh-syntax-highlighting)
    zle redisplay
    }
}

function cd() {
  emulate -L zsh
  builtin cd "$@" && ls --color
}


function tchx(){
    local shebang='#!/usr/bin' file
    for file in "$@"; do
        [ -e "$file" ] && continue
        case "$file" in
            *.py) print "$shebang/env python3" > "$file";;
            *.sh|*.bash) print "$shebang/bash\nset -euo pipefail" > "$file";;
            *.zsh) print "$shebang/zsh" > "$file";;
            *.pl) print "$shebang/perl" > "$file" ;;
            *) touch "$file" ;;
        esac

        # Hanya file executable yang di-chmod +x
        case "$file" in
            *.py|*.sh|*.bash|*.pl)
                chmod +x "$file"
                ;;
        esac
    done
}


function ghraw(){
    [ -z "$1" ] && { print "Usage: ghraw <github-url>"; return 1; }

    local url=$(sed 's#github.com/#raw.githubusercontent.com/#; s#/blob##'  <<< "$1")
    printf "raw url: %s" "$url"
    curl -fsSLO "$url" && print "done $PWD/${url:t}" || return

}

function quiet(){
    "$@" >&/dev/null
}

function wtfpl(){
    cat <<EOF > LICENSE
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO.
EOF
}

function editorconfig(){
    cat <<EOF >> .editorconfig
    # EditorConfig is awesome: https://EditorConfig.org

# top-most EditorConfig file
root = true

[*]
indent_style = space
indent_size = 4
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = false
insert_final_newline = false
EOF
}

function fk(){
  (( $+commands[thefuck] )) || { printf '%s\n' "didn't find thefuck in path"; return; }
  unfunction fk
  eval "$(thefuck --alias fk)" && fk "$@"
}


function yy(){
  local tmp="$(mktemp -t 'yazi-cwd.XXXXXX')"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}


# vim: ft=sh:nowrap

