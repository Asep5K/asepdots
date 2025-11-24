# Advanced Aliases.
# Use with caution
#

# ls, the common ones I use a lot shortened for rapid fire usage
alias exa="exa --icons"
alias ls="exa --icons"
alias l="exa -lh"
alias la="exa -la"   

alias zshrc="${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc"
alias chalias="${=EDITOR} ${ZDOTDIR:-$HOME}/alias.zsh" 
alias szsh="source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshrc"

alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

alias t='tail -f'

# Command line head / tail shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g P="2>&1| pygmentize -l pytb"

alias dud='du -d 1 -h'
(( $+commands[duf] )) || alias duf='du -sh *'
(( $+commands[fd] )) || alias fd='find . -type d -name'
alias ff='find . -type f -name'

alias h='history'
alias hgrep="fc -El 0 | grep"
alias help='man'
alias p='ps -f'
alias sortnr='sort -n -r'
alias unexport='unset'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
alias idiot="echo 'sudo rm -rf --no-preserve-root /'"
# timeshift
alias timeshiftgtk='xhost +SI:localuser:root && env -i DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin sudo /usr/sbin/timeshift-gtk && xhost -SI:localuser:root'
alias lmao="echo 'you are an idiot'"
alias lmfao="echo 'laughing my f***ing ass off'"
#alias cat="bat"
alias q="exit"
alias shizuku="adb shell sh /storage/emulated/0/Android/data/moe.shizuku.privileged.api/start.sh"
alias bedrock="nohup mcpelauncher-ui-qt %U &"
alias chx="chmod +x"
alias aria16="aria2c -x 16 -s 16"

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

# mpv
alias yt144='mpv --ytdl-format="bestvideo[height<=144]+bestaudio/best" '
alias yt240='mpv --ytdl-format="bestvideo[height<=240]+bestaudio/best" '
alias yt360='mpv --ytdl-format="bestvideo[height<=360]+bestaudio/best" '
alias yt480='mpv --ytdl-format="bestvideo[height<=480]+bestaudio/best" '
alias yt720='mpv --ytdl-format="bestvideo[height<=720]+bestaudio/best" '
alias yt1080='mpv --ytdl-format="bestvideo[height<=1080]+bestaudio/best"'

alias sshgit="ssh-add -q $HOME/.ssh/github/id_ed25519"
alias echi='echo'
alias cpr='cp -ir'
alias c="clear"
alias nime="animeku-cli || asepnime"
alias y='yazi'
alias mounthp='mkdir -p $HOME/Mountpoint/Mtp && jmtpfs $HOME/Mountpoint/Mtp'
alias umounthp='fusermount -u $HOME/Mountpoint/Mtp && echo "📱 Unmounted!"'
alias mountf='udisksctl mount -b'
alias unmountf='udisksctl unmount -b'
alias ejectf='udisksctl power-off -b'
alias copy='rsync -P'
alias Trash='yazi $HOME/.local/share/Trash'
alias biji='hyprland'
alias ignored='grep ^IgnorePkg /etc/pacman.conf | sed "s/IgnorePkg *= *//" | tr " " "\n"'
alias mkgrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias path="echo $PATH| tr ':' '\n'"

#######################################################
