#!/usr/bin/env bash

# Source: ViegPhunt
# URL: http://github.com/ViegPhunt/Dotfiles/blob/main/.config/viegphunt/key_hints.sh
if pidof yad > /dev/null; then
    pkill yad
fi

yad --center --title="Keybinding Hints" --no-buttons --list \
    --column=Key: --column="" --column=Description: \
    --timeout-indicator=bottom \
"  =   "          "        "  "SUPER KEY (Windows Key Button)" \
"" "" "" \
"  Q"              "        "  "Open terminal (kitty)" \
"  R"              "        "  "Open app menu (rofi)" \
"  T"              "        "  "Open Telegram" \
"  D"              "        "  "Open Discord" \
"  E"              "        "  "Open file manager (yazi)" \
"CTRL + TAB"        "        "  "Open window switcher (rofi)" \
"" "" "" \
"CTRL + SHIFT + ESC" "       "  "Open btop (floating)" \
"CTRL + ALT + E"    "        "  "Open file manager floating" \
"CTRL + ALT + C"    "        "  "Open cava (floating)" \
"CTRL + ALT + S"    "        "  "Open Spotify (floating)" \
"CTRL + ALT + X"    "        "  "Open cmus (floating)" \
"" "" "" \
"  H"              "        "  "Show keybinding hints" \
"ALT + Z"           "        "  "Clipboard manager" \
"  RETURN"         "        "  "Power menu" \
"" "" "" \
"  N"              "        "  "Random wallpaper" \
"F8"                "        "  "Toggle hypridle" \
"F10"               "        "  "Screen recorder" \
"PRINT"             "        "  "Screenshot (full)" \
"SHIFT + PRINT"     "        "  "Screenshot (area)" \
"" "" "" \
"  1..0"           "        "  "Switch workspaces 1–10" \
"  SHIFT + 1..0"   "        "  "Move window to workspace 1–10" \
"" "" "" \
"  A"              "        "  "Toggle split (dwindle)" \
"  B"              "        "  "Open Brave browser" \
"  C"              "        "  "Close active window" \
"  P"              "        "  "Pseudo (dwindle)" \
"  W"              "        "  "Toggle floating" \
"  BACKSPACE"      "        "  "Exit Hyprland" \
"" "" "" \
"  ←↑↓→"           "        "  "Move focus" \
"  SHIFT + ←↑↓→"   "        "  "Resize window" \
"  CTRL + SHIFT + ←↑↓→" "   " "Move active window" \
"" "" "" \
"XF86AudioRaiseVolume" "     " "Volume up" \
"XF86AudioLowerVolume" "     " "Volume down" \
"XF86AudioMute"      "       " "Toggle mute" \
"XF86MonBrightnessUp" "      " "Brightness up" \
"XF86MonBrightnessDown" "    " "Brightness down" \
"" "" "" \
"  S"              "        "  "Toggle scratchpad" \
"  SHIFT + S"      "        "  "Move window to scratchpad" \
"" "" "" \
"More Keybinding"   "        "  "$HOME/.config/hypr/configs/keybindings.conf"
