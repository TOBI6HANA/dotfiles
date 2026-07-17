---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local programs = require("programs")

local mainMod = "SUPER"
local terminal = programs.terminal
local fileManager = programs.fileManager
local menu = programs.menu

-- Applications
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(menu))

-- Window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Move focus
hl.bind(mainMod .. " + H", function()
	hl.dispatch(hl.dsp.focus({ direction = "l" }))
	hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)

hl.bind(mainMod .. " + J", function()
	hl.dispatch(hl.dsp.focus({ direction = "d" }))
	hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)

hl.bind(mainMod .. " + K", function()
	hl.dispatch(hl.dsp.focus({ direction = "u" }))
	hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)

hl.bind(mainMod .. " + L", function()
	hl.dispatch(hl.dsp.focus({ direction = "r" }))
	hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)

hl.bind(mainMod .. " + Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next())
	hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)

-- Move windows
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

-- Floating
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.move({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.move({ x = 30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.move({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.move({ x = 0, y = 30, relative = true }), { repeating = true })

-- Resize windows
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
	hl.bind("h", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
	hl.bind("l", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
	hl.bind("k", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })
	hl.bind("j", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })

	hl.bind("Escape", hl.dsp.submap("reset"))
end)

-- Switch workspaces with mainMod + [1-5]
-- Move active window to a workspace with mainMod + SHIFT + [1-5]
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Reload config
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- Multimedia keys for volume
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("swayosd-client --output-volume raise"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("swayosd-client --output-volume lower"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("~/.config/swayosd/mic-mute-toggle.sh"))
-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Hyprlock
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("hyprlock"))

-- Vicinae
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("vicinae vicinae://launch/clipboard/history"))
hl.bind(mainMod .. " + Period", hl.dsp.exec_cmd("vicinae vicinae://launch/core/search-emojis"))

-- wlogout
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("wlogout"))

-- Fan control
hl.bind("XF86Tools", hl.dsp.exec_cmd("/usr/local/bin/fan-toggle.sh"))

-- Notifications
hl.bind(mainMod .. " + n", hl.dsp.exec_cmd("swaync-client -t"))

-- Waybar
hl.bind(mainMod .. " + SHIFT + b", hl.dsp.exec_cmd("~/.config/waybar/launch.sh"))
