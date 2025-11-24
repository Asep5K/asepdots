---@diagnostic disable: undefined-global

local configs  = {
	'env',
	'keybinds',
	'decorations',
	'windowrules',
  'animations',
  'submaps',
}

for _, i in ipairs(configs) do
	require('configs.'.. i)
end

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = '',
    mode     = 'preferred',
    position = 'auto',
    scale    = 'auto',
})

-- hl.config({ ['animations.enabled'] = false })
-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on('hyprland.start', function()
    hl.exec_cmd('pidof awww-daemon || awww-daemon')
    hl.exec_cmd('pidof hypridle || hypridle')
    hl.exec_cmd('wl-paste --type text --watch cliphist store')
    hl.exec_cmd('wl-paste --type image --watch cliphist store')
    hl.exec_cmd('dbus-update-activation-environment --systemd WAYLAND_DISPLAY')
    -- hl.exec_cmd('systemctl --user enable --now foot-server.socket')
    hl.exec_cmd('/usr/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 10%')
end)

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })


----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = 'us',
        kb_variant = '',
        kb_model   = '',
        kb_options = 'caps:escape_shifted_capslock',
        kb_rules   = '',

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
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = 1.00,
})

-- hl.window_rule({ no_anim = true, match = "class:alttab" })

hl.on('window.fullscreen', function()
  hl.config({ ["decoration.blur.enabled"] = false })
  hl.window_rule({opacity = '1.0', match = {class = '.*'}})
end)

-- vim: ft=lua:nowrap
