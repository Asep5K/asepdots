alias uvp='uv pip'
alias scv='source .venv/bin/activate'
alias resister='nohup wine $HOME/holyshit/resister/ReSister.exe >& /tmp/resister.log &'
alias unlockdb='sudo rm -f /var/lib/pacman/db.lck'
alias wlp='wl-paste'
alias wlc='wl-copy'

alias whichpkg='pkgfile -b'
alias -g void='>&/dev/null'
alias -g noerr='2>/dev/null'
alias -g noout='>/dev/null'
alias -g @1='>/dev/null'
alias -g @2='2>/dev/null'
alias -g @12='>&/dev/null'
# git
alias gcl='git clone'
alias gst='git status'
alias gitignore='git status --ignored'
alias gpl='git pull'
alias gengitignore='awokawok'
alias malas_commit='git commit -m "$(curl -s https://whatthecommit.com/index.txt)"'
alias males_push='git add . && males_commit && git push origin $(git branch --show-current)'
alias yolo='git add . && males_commit && git push --force'

# python
alias py='python'
alias pipl='pip list'
alias pipe='pip install -e'
alias pipuns='pip uninstall'
alias pipout='pip list --oudated'
alias pipins='pip install --upgrade'
alias pipdl='pip download -d ./packages'
alias pipreq='pip install -r requirements.txt'
alias pipf='pip freeze | tee requirements.txt'
alias pipclean='pip freeze | xargs pip uninstall -y'
alias pipfv="pipf && sed -i 's/==.*//g' requirements.txt"
alias pipupal="pip list --outdated | tail -n +3 | awk '{print \$1}' | xargs pip install --upgrade"
alias hvenv='. $HOME/.venv/bin/activate'
alias mkvenv='python -m venv .venv'
#  yt-dlp
alias ydl='yt-dlp'

alias bt='bat'
# eles
alias exa='eza --icons -1'
alias eza='eza --icons -1'
alias sl='ls'
alias ls='eza'
alias lgbt='eza -lGbT'
alias l='eza -lh'
alias la='eza -la'
alias zshrc='${=EDITOR} $ZDOTDIR/.zshrc'
alias chalias='${=EDITOR} $ZDOTDIR/conf.d/aliases.zsh'
alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
alias t='tail -f'
alias dud='du -d 1 -h'
(( $+commands[duf] )) || alias duf='du -sh *'
(( $+commands[fd] )) || alias fd='find . -type d -name'
alias ff='find . -type f -name'

alias h='history'
alias hgrep="fc -El 0 | grep"
alias rtfm='man'
alias p='ps -f'
alias sortnr='sort -n -r'
alias unexport='unset'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias sc='source'
alias packages="pacman -Qi | awk '/^Name/{name=\$3} /^Installed Size/{size=\$4 \" \" \$5; print name, size}' | sort -k2 -h -r"

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
alias aria='aria2c -x 5 -s 5'
alias mkdir='mkdir -p'
alias idiot='print sudo rm -rf --no-preserve-root /'
alias rmcache='rm -rf $XDG_CACHE_HOME/*'
alias rmtrash='rm -rf $XDG_DATA_HOME/Trash/{files,info}/*'

# timeshift
alias timeshiftgtk='xhost +SI:localuser:root && env -i DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin sudo /usr/sbin/timeshift-gtk && xhost -SI:localuser:root'
alias lmao='print you are an idiot'
alias lmfao='print laughing my f***ing ass off'

alias q='exit'
alias shizuku='adb shell sh /storage/emulated/0/Android/data/moe.shizuku.privileged.api/start.sh'
alias bedrock='mcpelauncher-ui-qt %U & disown'
alias chx='chmod +x'
alias aria16='aria2c -x 16 -s 16 --no-conf=true'

# Fastboot
alias fbr='fastboot reboot'
alias fbrr='fastboot reboot recovery'
alias fbrb='fastboot reboot bootloader'
alias fbrf='fastboot reboot fastboot'
alias fbfb='fastboot flash boot'
alias fbfsu='fastboot flash super'
alias fbfs='fastboot flash system'
alias fbes='fastboot erase system'
alias fbf='fastboot flash'
alias fbe='fastboot erase'

# Adb
alias adbrf='adb reboot fastboot'
alias adbrb='adb reboot bootloader'
alias adbd='adb devices'
alias adbpl='adb pull'
alias adbps='adb push'

alias echi='echo'
alias cpr='cp -ir'
alias c='clear'
alias nime='animeku-cli'
alias y='yazi'
alias mountf='udisksctl mount -b'
alias unmountf='udisksctl unmount -b'
alias ejectf='udisksctl power-off -b'
alias biji='hyprland'
alias ignored='grep ^IgnorePkg /etc/pacman.conf | sed "s/IgnorePkg *= *//" | tr " " "\n"'
alias mkgrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias path='print $PATH | tr : "\n"'
alias fpath='print $FPATH | tr : "\n"'
alias ytalias='grep ^--alias $XDG_CONFIG_HOME/yt-dlp/config'


# vim:ft=zsh:nowrap
