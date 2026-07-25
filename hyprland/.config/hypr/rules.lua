--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Ignore maximize requests from all apps
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.window_rule({
	match = { class = "steam" },
	float = true,
	center = true,
})

hl.window_rule({
	match = {
		class = "steam",
		title = "Steam",
	},
	float = false,
})

hl.window_rule({
	match = {
		title = "Geometry Dash",
	},
})

hl.window_rule({
	match = {
		class = "org.vinegarhq.Sober",
	},
	float = true,
	center = true,
})

hl.window_rule({
	match = {
		title = "Sober",
	},
	float = false,
	fullscreen = true,
})

hl.window_rule({
	match = {
		class = "^(mpv|com.interversehq.qView)$",
	},
	float = true,
	center = true,
	size = "1280 720",
})

hl.window_rule({
	match = {
		class = "mpv",
	},
	size = "1600 900",
})

hl.layer_rule({
	match = { class = "Vesktop" },
	blur = true,
})

hl.layer_rule({
	match = { namespace = "waybar" },
	blur = false,
})

hl.layer_rule({
	match = { class = "swaync" },
	blur = false,
})

-- Fix some dragging issues with XWayland
hl.window_rule({
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

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

-- Layer rules
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })

hl.workspace_rule({ workspace = "1", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "7", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "9", monitor = "HDMI-A-1" })
