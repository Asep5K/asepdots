-- Example window rules that are useful
---@diagnostic disable: undefined-global

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)
local rofiNoanim = hl.layer_rule({
	name = "disable anime for rofi",
	match = { namespace = "rofi|selection" },
	no_anim = true,
})

local layerPler = hl.layer_rule({
	name = "layer peler",
	match = { namespace = "^(bottom-bar|waybar|notifications|gtk4?-layer-shell)" },
	ignore_alpha = 0.5,
	blur = true,
	animation = "slide",
})

local bar = hl.layer_rule({
	name = "foobar",
	match = { namespace = "bottom-bar" },
	blur = true,
	ignore_alpha = 0.5,
})

rofiNoanim:set_enabled(true)
layerPler:set_enabled(true)
bar:set_enabled(true)
local ewwwidget = hl.layer_rule({
	name = "eww widget",
	match = { namespace = "^(bottom-bar|right-menu|sysinfo)" },
	ignore_alpha = 0.5,
	blur = true,
})

ewwwidget:set_enabled(true)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	name = "tempwk",
	match = { class = "foot(?:client)?" },
	tag = "terminal",
	-- opacity = 0.8,
})

hl.window_rule({
	name = "System monitor",
	float = true,
	match = { class = "btop", title = "btop" },
	size = { "(monitor_w*0.85)", "(monitor_h*0.95)" },
})

hl.window_rule({
	match = { class = "mpv" },
	float = true,
	size = { "(monitor_w*0.5)", "(monitor_h*0.5)" },
	content = "video",
	center = true,
})

hl.window_rule({
	name = "disable idleinhibit",
	match = { class = "mpv|brave-browser" },
	idle_inhibit = "fullscreen",
})

hl.window_rule({
	name = "apply opacity for spotify",
	match = { class = "[Ss]potify" },
	opacity = 1.0,
})

hl.window_rule({
	name = "alttab",
	no_anim = true,
	match = { class = "alttab" },
	float = true,
	maximize = true,
})

hl.window_rule({
	name = "floating terminal",
	float = true,
	center = true,
	size = { "(monitor_w*0.5)", "(monitor_h*0.5)" },
	match = { class = "foot(?:client)?", title = "floating foot" },
})

-- vim: ft=lua:nowrap
