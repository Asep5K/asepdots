if [[ "$TERM" = "foot" || "$TERMINAL" = "foot" ]]; then
    _foot_osc7() {
        printf "\033]7;file://%s%s\033\\" "$HOST" "$PWD"
    }
    _foot_osc133() {
        printf "\033]133;%s\033\\" "$1"
    }

    precmd_functions+=(_foot_osc7)
    chpwd_functions+=(_foot_osc7)

    _foot_preexec() {
        _foot_osc133 C
    }
    preexec_functions+=(_foot_preexec)

    _foot_precmd() {
        _foot_osc133 D
        _foot_osc133 A
    }
    precmd_functions+=(_foot_precmd)
fi
