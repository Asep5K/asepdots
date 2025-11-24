# Advanced Aliases.
# Use with caution
#

# ls, the common ones I use a lot shortened for rapid fire usage
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'
alias lsr='ls -lARFh' #Recursive list of files and directories
alias lsn='ls -1'     #A column contains name of files and directories
alias bashrc='${EDITOR} ${BASHCONFIG:-$HOME/.config/bash}/.bashrc' # Quick access to the .bashrc file
alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
alias t='tail -f'
alias dud='du -d 1 -h'
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

# yt-dlp
alias yt144='mpv --ytdl-format="bestvideo[height<=144]+bestaudio/best" '
alias yt240='mpv --ytdl-format="bestvideo[height<=240]+bestaudio/best" '
alias yt360='mpv --ytdl-format="bestvideo[height<=360]+bestaudio/best" '
alias yt480='mpv --ytdl-format="bestvideo[height<=480]+bestaudio/best" '
alias yt720='mpv --ytdl-format="bestvideo[height<=720]+bestaudio/best" '
alias yt1080='mpv --ytdl-format="bestvideo[height<=1080]+bestaudio/best" '
alias yt1440='mpv --ytdl-format="bestvideo[height<=1440]+bestaudio/best" '
alias yt2k='mpv --ytdl-format="bestvideo[height<=2160]+bestaudio/best" '

# git
alias gcl="git clone"

alias echi='echo'
alias cpr='cp -ir'
alias c="clear"
alias chalias="nvim ${XDG_CONFIG_HOME:-$HOME/.config/bash}/alias.bash"
alias nime='animeku-cli'
alias asep="$HOME/.venv/bin/python -m pip"
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
alias backup="sudo timeshift --create --comments "$1""
#eval "$(thefuck --alias mulyono)"
alias mkgrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
#######################################################
