-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	-- hl.exec_cmd('systemctl --user enable --now foot-server.socket')
	hl.exec_cmd("eww daemon & eww open bar & eww open workspace_hover")
	hl.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 10%")
	hl.exec_cmd("xrdb -merge $HOME/.Xresources")
	hl.exec_cmd("hyprctl plugin load $XDG_CONFIG_HOME/hypr/plugins/libhyprexpo.so")
	hl.exec_cmd("hypridle")
end)
