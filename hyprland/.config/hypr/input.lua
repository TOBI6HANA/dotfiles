---------------
---- INPUT ----
---------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
hl.config({
	input = {
		kb_layout = "us,ua",
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:alt_shift_toggle",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0.75, -- -1.0 - 1.0, 0 means no modification

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

-- Per-device config
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})
