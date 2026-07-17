-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 20,

		border_size = 2,

		col = {
			active_border = { colors = { "rgba(d14dffff)", "rgba(2d8fffff)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = true,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = true,

		layout = "dwindle",
	},

	decoration = {
		rounding = 10,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1,
		inactive_opacity = 1,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			ignore_opacity = true,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

hl.curve("smoothOut", { type = "bezier", points = { { 0.25, 1 }, { 0.4, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("silk", { type = "spring", mass = 1, stiffness = 90, dampening = 20 })

hl.animation({ leaf = "global", enabled = true, speed = 10, spring = "silk" })
hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "smoothOut" })

-- window open/close now slide instead of pop
hl.animation({ leaf = "windows", enabled = true, speed = 4.5, spring = "silk", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, spring = "silk", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "smoothOut", style = "slide" })

-- this is the key leaf: keep tile resizing in sync so gaps don't lag behind the close animation
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3.2, bezier = "smoothOut" })

hl.animation({ leaf = "fade", enabled = true, speed = 3.5, bezier = "almostLinear" })
hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "smoothOut", style = "fade" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, spring = "silk", style = "slidefade 15%" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, spring = "silk" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only" -- uncomment all if you wish to use that
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

hl.layer_rule({
	match = { namespace = "wlogout" },
	blur = true,
	ignore_alpha = 0.0,
})

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
})

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
	},
})
