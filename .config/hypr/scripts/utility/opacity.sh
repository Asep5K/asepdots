#!/usr/bin/env bash


opacity_conf="$HYPRCONFIG/.temp/opacity.conf"


write(){
    cat <<-EOF > "$opacity_conf"
windowrule =  match:tag terminal*, opacity 0.8 $& 0.8 $& 
windowrule =  match:tag musicplayer*, opacity 0.8 $& 0.8 $& 
windowrule =  match:tag filemanager*, opacity 0.8 $& 0.8 $& 
# windowrule =  match:tag explorer*, opacity 0.8 $& 0.8 $& 
# windowrule =  match:tag social*, opacity 0.8 $& 0.8 $& 


decoration {
    blur {
        enabled = true
        size = 5
        passes = 2
    }
}
EOF

}

function set_opacity(){
    if [[ -f  "$opacity_conf" ]]; then
        rm -f "$opacity_conf"
        hyprctl reload
    else
        write && hyprctl reload
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    set_opacity
fi
