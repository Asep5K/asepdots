----------------
---- SUBMAP ----
----------------

hl.bind("SUPER + ESCAPE", hl.dsp.submap("reset"), { submap_universal = true })

-- Switch to a submap called `resize`.
hl.bind("ALT + R", hl.dsp.submap("resize"))

-- Start a submap called "resize".
hl.define_submap("resize", function()
	-- Set repeating binds for resizing the active window.
	hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("up", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("down", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })

	-- Use `reset` to go back to the global submap
	hl.bind("escape", hl.dsp.submap("reset"))
end)

hl.bind("CTRL + SHIFT + P", function()
	hl.bind("CTRL + SHIFT + P", function()
		hl.config({
			["misc.enable_swallow"] = true,
			["misc.swallow_regex"] = "^(foot(?:client)?|kitty|Alacritty)$",
		})
		hl.dispatch(hl.dsp.window.toggle_swallow())
	end)
end)

hl.bind("ALT + O", function()
	local monitor = hl.get_active_monitor()
	local act = "disable"
	if monitor and monitor.dpms_status == true then
		hl.dispatch(hl.dsp.exec_cmd("pidof hypridle && pkill hypridle"))
	else
		act = "enable"
	end
	hl.dispatch(hl.dsp.dpms({ action = act }))
end, { locked = true })

hl.bind("ALT + P", function()
	hl.window_rule({ opacity = 1.0, match = { class = ".*" } })
	hl.config({ ["animations.enabled"] = false })
end)

-- keybinding scrolling
hl.bind("SUPER + F", hl.dsp.layout("colresize +conf"))
hl.bind("SUPER + SHIFT + F", hl.dsp.layout("colresize -conf"))
-- vim: nowrap
