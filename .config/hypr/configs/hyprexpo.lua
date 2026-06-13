hl.config({
	plugin = {
		hyprexpo = {
			columns = 3,
			gaps_in = 5,
			gaps_out = 0,
			bg_col = "rgb(111111)",
			workspace_method = "center current",
			gesture_distance = 200,
			cancel_key = "escape",
			show_cursor = 1,
		},
	},
})

local xyz = {
	{ "h", "left" },
	{ "j", "down" },
	{ "k", "up" },
	{ "l", "right" },
	{ "escape", "cancel" },
}

hl.define_submap("hyprexpo", function()
	for _, i in ipairs(xyz) do
		hl.bind(i[1], function()
			hl.plugin.hyprexpo.kb_focus(i[2])
		end)
	end
	for _, i in ipairs({ "SUPER + O", "O", "return" }) do
		hl.bind(i, function()
			hl.plugin.hyprexpo.kb_confirm()
		end)
	end
end)

hl.bind("SUPER + O", function()
	hl.plugin.hyprexpo.expo("toggle")
end, { submap_universal = true })
