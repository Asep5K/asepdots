---@diagnostic disable: undefined-global
---------------------
---- KEYBINDINGS ----
---------------------
local mod = "SUPER"
local terminal = "foot"
-- local editor = "codium"
local browser = "vivaldi"
local filemanager = terminal .. " --title=yazi yazi"
local scripts = "$HOME/.config/hypr/scripts/"

----------------------
---- APPLICATIONS ----
----------------------
hl.bind(mod .. " + CTRL + RETURN", hl.dsp.exec_cmd(terminal))
-- hl.bind(mod .. " + V", hl.dsp.exec_cmd(editor))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(filemanager))
hl.bind(mod .. " + B", hl.dsp.exec_cmd(browser))

-- Window Controls & Quick Terminals
hl.bind("F11", hl.dsp.window.fullscreen({ mode = "fullscreen" }), { release = true })
hl.bind(mod .. " + SHIFT + Q", hl.dsp.exec_cmd(terminal .. " --title='floating foot'"))
hl.bind(
	"CTRL + SHIFT + ESCAPE",
	hl.dsp.exec_cmd(terminal .. " --title=btop --app-id=btop btop"),
	{ description = "open system monitor", submap_universal = true }
)
hl.bind(mod .. " + CTRL + M", hl.dsp.exec_cmd(scripts .. "mode.sh"))

--------------
---- ROFI ----
--------------
local rofi = "pkill rofi || rofi"
hl.bind(mod .. " + R", hl.dsp.exec_cmd(rofi .. " -show drun -show-icons -icon-theme Papirus"), { release = true })
hl.bind("ALT + SPACE", hl.dsp.exec_cmd(rofi .. " -show emoji"), { release = true })
hl.bind(
	"ALT + X",
	hl.dsp.exec_cmd("pkill rofi || cliphist list | rofi -dmenu -p clipboard | cliphist decode | wl-copy"),
	{ release = true }
)

--------------------
---- WORKSPACES ----
--------------------

-- Focus Navigation (Vim Style: HJKL)
local vim_directions = {
	{ key = "H", til = "left" },
	{ key = "J", til = "down" },
	{ key = "K", til = "up" },
	{ key = "L", til = "right" },
}

for _, i in ipairs(vim_directions) do
	hl.bind(mod .. " + " .. i.key, hl.dsp.focus({ direction = i.til }))
end

hl.bind(mod .. " + U", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mod .. " + I", hl.dsp.focus({ workspace = "r-1" }))

-- Switch & move window (1 - 10)
for i = 1, 10 do
	local key = i % 10
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scratchpad (Special Workspace)
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll workspaces
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

------------------
---- GROUPING ----
------------------
hl.bind(mod .. " + G", hl.dsp.group.toggle())
hl.bind(mod .. " + SHIFT + G", hl.dsp.window.move({ out_of_group = true }))
hl.bind(mod .. " + ALT + H", hl.dsp.group.prev())
hl.bind(mod .. " + ALT + L", hl.dsp.group.next())

----------------------
---- FOCUS / MOVE ----
----------------------

-- Arrow Keys Navigation & Intelligent Move
local move_directions = {
	{ key = "left", x = -30, y = 0, tiling = "left" },
	{ key = "right", x = 30, y = 0, tiling = "right" },
	{ key = "up", x = 0, y = -30, tiling = "up" },
	{ key = "down", x = 0, y = 30, tiling = "down" },
}

for _, i in ipairs(move_directions) do
	-- Move focus with mainMod + arrow keys
	hl.bind(mod .. " + " .. i.key, hl.dsp.focus({ direction = i.tiling }))

	-- Move active window intelligently (Floating vs Tiling)
	hl.bind(mod .. " + SHIFT + CTRL + " .. i.key, function()
		local active_window = hl.get_active_window()
		if active_window and active_window.floating then
			hl.dispatch(hl.dsp.window.move({ x = i.x, y = i.y, relative = true }))
		else
			hl.dispatch(hl.dsp.window.move({ direction = i.tiling }))
		end
	end, { description = "Move active window intelligently", repeating = true })
end

hl.bind("SUPER + TAB", function()
	hl.dispatch(hl.dsp.window.cycle_next())
	hl.dispatch(hl.dsp.window.bring_to_top())
end)

---------------------------
---- WINDOW MANAGEMENT ----
---------------------------
hl.bind(mod .. " + C", hl.dsp.window.close())
hl.bind(mod .. " + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"))

-- Drag & resize
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + Z", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mod .. " + X", hl.dsp.window.resize(), { mouse = true })

--------------------
---- MULTIMEDIA ----
--------------------

-- Audio Controls
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	mod .. " + ALT + RIGHT",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	mod .. " + ALT + LEFT",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

-- Brightness Controls
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
	{ submap_universal = true, locked = true, repeating = true }
)
hl.bind(
	mod .. " + ALT + UP",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
	{ submap_universal = true, locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
	{ submap_universal = true, locked = true, repeating = true }
)
hl.bind(
	mod .. " + ALT + DOWN",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
	{ submap_universal = true, locked = true, repeating = true }
)

-- Player Controls
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { submap_universal = true, locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { submap_universal = true, locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { submap_universal = true, locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { submap_universal = true, locked = true })

-------------------
---- UTILITIES ----
-------------------
hl.bind(mod .. " + ALT + CTRL + BACKSPACE", hl.dsp.exec_cmd(scripts .. "power.sh"), { description = "open power menu" })

--[[
 hl.bind(
	"ALT + ESCAPE",
	hl.dsp.exec_cmd("pidof waybar && pkill waybar || waybar"),
	{ description = "toggle waybar", release = true }
)
--]]

hl.bind(mod .. " + SHIFT + R", function()
	hl.dispatch(hl.dsp.exec_cmd("hyprctl reload"))
	hl.notification.create({
		text = "Config Reloaded Successfully!",
		timeout = 2000,
		color = "#00ffcc",
		font_size = 25,
	})
end, { description = "Reload Config + Notif" })

hl.bind("F12", hl.dsp.exec_cmd("notify-send --expire-time=5000 $(date +%r)"))

-------------------
---- WALLPAPER ----
-------------------
hl.bind(mod .. " + SEMICOLON", function()
	hl.window_rule({
		opacity = 0.8,
		match = { class = "wallpaper" },
		no_anim = true,
		float = true,
		fullscreen = true,
	})
	hl.dispatch(hl.dsp.exec_cmd(string.format("%s --app-id=wallpaper %swallpaper.sh", terminal, scripts)))
end)

local w = scripts .. "wallpaper/wallpaper.sh "
hl.bind(mod .. " + M", hl.dsp.exec_cmd(w .. "-s"), { description = "gui wallpaper selector", release = true })
hl.bind(mod .. " + N", hl.dsp.exec_cmd(w .. "-r"), { description = "random wallpaper toggle", release = true })

--------------------
---- SCREENSHOT ----
--------------------
local function screenshot(bindings, mode)
	local cmd = "grimblast --notify copysave " .. mode .. "$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
	hl.bind(bindings, hl.dsp.exec_cmd(cmd), { release = true })
end
screenshot("PRINT", "screen ")
screenshot("SHIFT + PRINT", "area ")

-------------------------
---- LAYOUT CONTROLS ----
-------------------------
local current_layout = hl.get_config("general.layout")
if current_layout then
	hl.bind(mod .. " + CTRL + J", hl.dsp.layout("move +col"))
	hl.bind(mod .. " + CTRL + K", hl.dsp.layout("move -col"))
	hl.bind(mod .. " + CTRL + L", hl.dsp.layout("swapcol l"))
	hl.bind(mod .. " + CTRL + H", hl.dsp.layout("swapcol r"))
end

hl.bind("mouse:275", hl.dsp.exec_cmd("notify-send ambasync"), { repeating = true })
hl.bind("mouse:276", hl.dsp.exec_cmd("notify-send kontol"))

-- vim: ft=lua:nowrap
