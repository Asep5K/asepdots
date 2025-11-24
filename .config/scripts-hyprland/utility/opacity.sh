#!/usr/bin/env bash

XDG_HYPR_TEMP="${XDG_CONFIG_HOME:-$HOME/.config}/hypr/.temp"
FILE="$XDG_HYPR_TEMP/opacity.conf"

write(){
    cat <<-EOF > "$FILE"
windowrulev2 = opacity 0.5 0.5, class:^(foot|footclient)$
windowrulev2 = opacity 0.8 0.8, class:(?i)^(spotify|chromium-browser)$
# windowrulev2 = opacity 0.5 0.5, class:(?i)^(spotify|code|code-oss|brave-browser|discord)$
# windowrulev2 = opacity 0.9 0.9, class:^(code|code-oss)$
# windowrulev2 = opacity 0.7 0.7, initialTitle:(?i)^(Telegram|discord)$

decoration {
    blur {
        enabled = true
        size = 5
        passes = 2
    }
}
EOF
}

if [[ -f  "$FILE" ]]; then
    rm -f "$FILE"
    hyprctl reload
else
    write && hyprctl reload
fi