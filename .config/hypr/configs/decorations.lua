---@diagnostic disable: undefined-global
-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 2,
		border_size = 2,
		col = {
			-- active_border = { colors = { 'rgba(126,241,254,1)' } },
			active_border = "rgb(136, 57, 239)",
			inactive_border = "rgb(76, 79, 105)",
		},
		resize_on_border = true,
		layout = "scrolling",
		allow_tearing = false,
	},
	decoration = {
		rounding = 10,
		rounding_power = 10,

		shadow = {
			enabled = false,
			range = 10,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},

		blur = {
			enabled = true,
			size = 10,
			passes = 1,
			vibrancy = 0.15,
			brightness = 0.8,
			contrast = 0.9,
		},
	},
	animations = {
		enabled = true,
	},
	cursor = {
		inactive_timeout = 5,
		hide_on_key_press = true,
		hide_on_touch = true,
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
--hl.config({
--    dwindle = {
--        preserve_split = true, -- You probably want this
--rounding_power    },
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		new_status = "master",
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
		follow_focus = true,
		focus_fit_method = 1,
	},
})

hl.config({
	group = {
		col = {
			border_active = "rgb(151, 193, 198)",
			border_inactive = "rgb(251, 11, 163)",
		},
		groupbar = {
			text_color = "rgba(126,241,254,1)",
			text_color_inactive = "rgb(235, 54, 54)",
			indicator_gap = 3,
			indicator_height = 2,
			font_size = 15,
			font_family = "Monocraft Nerd Font",
			col = {
				active = "rgba(126,241,254,1)",
				inactive = "rgb(142, 123, 161)",
			},
		},
	},
})

-- vim: ft=lua:nowrap
