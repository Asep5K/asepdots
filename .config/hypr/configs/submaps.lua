-- Switch to a submap called `resize`.
hl.bind("ALT + R", hl.dsp.submap("resize"))

-- Start a submap called "resize".
hl.define_submap("resize", function()

    -- Set repeating binds for resizing the active window.
    hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true}), { repeating = true })
    hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true}), { repeating = true })
    hl.bind("up", hl.dsp.window.resize({ x = 0, y = 10, relative = true}), { repeating = true })
    hl.bind("down", hl.dsp.window.resize({ x = 0, y = -10, relative = true}), { repeating = true })

    -- Use `reset` to go back to the global submap
    hl.bind("escape", hl.dsp.submap("reset"))

end)


hl.bind('ALT + P', function ()
  hl.window_rule({ opacity = 1.0, match = { class = '.*' }})
  hl.config({ ["animations.enabled"] = false })
--  hl.dsp.submap('gemink')
end)

--hl.define_submap('gemink', function ()
  -- hl.config({ ["animations.enabled"] = false })
--hl.bind('ESCAPE', hl.dsp.submap('reset'))
  --
--end)

-- vim: nowrap
