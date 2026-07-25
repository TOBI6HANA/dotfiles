-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

local programs = require("programs")

hl.on("hyprland.start", function()
	hl.exec_cmd(programs.terminal)
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("udiskie")
	hl.exec_cmd("swaync")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("easyeffects --gapplication-service")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user start graphical-session.target")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("~/.config/awww/wallpaper-random.sh")
	hl.exec_cmd("swayosd-server --style ~/.config/swayosd/style.css")
	hl.exec_cmd("obs --startreplaybuffer --minimize-to-tray")
	hl.exec_cmd("vicinae server --replace")
end)

hl.on("hyprland.shutdown", function()
	hl.exec_cmd("pkill -INT obs")
end)
