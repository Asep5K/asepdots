---@diagnostic disable: undefined-global
-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- Wayland / Session Environment
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("ELECTRON_OZONE_PLATFORM", "auto")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("OZONE_PLATFORM", "wayland")

-- Qt Applications
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")

-- GTK & Theme Settings
-- hl.env('GTK_THEME', 'ElysiaOS')
-- hl.env('ICON_THEME', 'ElysiaOS')
-- hl.env('GTK_ICON_THEME', 'ElysiaOS')

-- Cursor Settings
hl.env("XCURSOR_SIZE", "100")
hl.env("HYPRCURSOR_SIZE", "120")
hl.env("XCURSOR_THEME", "Elysia-Herrscher-of-Human")
--hl.env("HYPRCURSOR_THEME", "Future-Cyan-Hyprcursor_Theme")

-- vim: ft=lua:nowrap
