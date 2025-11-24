function dl(){
    local url="$1"
    local tool=()
    if command -v aria2c >&/dev/null; then
        tool=(aria2c -q)
    elif command -v wget >&/dev/null; then
        tool=(wget -q)
    elif command -v curl >&/dev/null; then
        tool=(curl -sLO)
    else
        echo "Error: No download tool found (aria2c, curl, or wget)" >&2
        return 1
    fi
    if [ -z "$url" ]; then
        echo "${tool[*]}" 
    else
        "${tool[@]}" "$url"
        echo "Download succsessfully: $(basename "$url")"
    fi
}

function ghraw(){
    [[ -z "$1" ]] && { echo "Usage: ghraw <github-url>"; return 1; }
    
    local link=$(sed 's#github.com/#raw.githubusercontent.com/#; s#/blob##'  <<< "$1")
    
    echo "raw link: $link"
    if dl "$link"; then
        chmod +x "$(basename "$link")"
        echo "Download succsessfully: $(basename "$link")"
    else
        echo "Download failed"
    fi
}

function nyomot(){
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: nyomot <github_repo> <folder>"
        echo "Example: nyomot Asep5K/asepyt bin/ytpy"
        return 1
    fi

    local repo="$1"
    local folder="$2"

    local link="https://github.com/$repo.git"
    local temp="/tmp/nyomot_$$"

    local dest="$HOME/Clone/Nyomot/$(dirname $repo)/$(dirname $folder)"
    mkdir -p "$dest"

    git clone --filter=blob:none --sparse "$link" "$temp" || return 1
    cd "$temp" || return 1

    git sparse-checkout init --cone
    git sparse-checkout set "$folder"

    # ambil default branch (main/master/dll)
    local branch=$(git symbolic-ref --short refs/remotes/origin/HEAD | sed 's@^origin/@@')
    git pull origin "$branch"

    mv "$temp/$folder" "$dest" || return 1

    rm -rf "$temp" && cd "$dest"
    echo "✔️ Berhasil nyomot: $folder → $dest/"
}

function get_album_art(){
	local dir="$HOME/Pictures/album_art"
	local name="$(playerctl metadata xesam:title).jpg"
	local link="$(playerctl metadata mpris:artUrl)"
	local output="$dir/$name"
	
    if [ -f "$dir/$name" ]; then
        echo "Album art exists - skipping: $dir/$name"
        chafa "$output"
    else
	    mkdir -p "$dir"
        aria2c -q "$link" -d "$dir" -o "$name"
        echo "Album art saved: $dir/$name"
        chafa "$output"
    fi
}

function weather(){
    local location=${1:-rimbo_ulu}
    curl "wttr.in/$location?lang=id"
}

function backup_timeshift() {
    local default_name="backup_$(date +%Y-%m-%d_%H-%M-%S)"
    local backup_name="${1:-$default_name}"
    
    echo "Creating backup: $backup_name"
    
    if ! sudo timeshift --create --comments "$backup_name"; then
        echo "Backup failed" >&2
        return 1
    fi
    echo "Backup successful: $backup_name"
}

extract(){
    local file="$1"
    if [ -f "$file" ]; then
        case "$file" in
            *.tar.bz2) tar xjf "$file" ;;
            *.tar.gz) tar xzf "$file" ;;
            *.bz2) bunzip2 "$file" ;;
            *.rar) unrar x "$file" ;;
            *.gz) gunzip "$file" ;;
            *.tar) tar xf "$file" ;;
            *.tbz2) tar xjf "$file" ;;
            *.tgz) tar xzf "$file" ;;
            *.zip) unzip "$file" ;;
            *.Z) uncompress "$file" ;;
            *.7z) 7z x "$file" ;;
            *) echo "'$file' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$file' is not a valid file"
    fi
}

