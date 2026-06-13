---@diagnostic disable: undefined-global

local configs = {
	"env",
	"autostart",
	"keybinds",
	"decorations",
	"windowrules",
	"animations",
	"submaps",
	"hyprexpo",
}

for _, i in ipairs(configs) do
	require("configs." .. i)
end

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = 1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "caps:escape_shifted_capslock",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.device({
	name = "epic-mouse-v1",
	sensitivity = 1.0,
})

hl.on("workspace.active", function()
	local active_ws = hl.get_active_workspace()
	if active_ws then
		hl.exec_cmd("eww update active_workspace=" .. active_ws.id)
	end
end)

-- vim: ft=lua:nowrap
