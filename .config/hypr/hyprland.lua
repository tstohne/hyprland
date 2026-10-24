--  _   _                  _                 _
-- | | | |_   _ _ __  _ __| | __ _ _ __   __| |
-- | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
-- |  _  | |_| | |_) | |  | | (_| | | | | (_| |
-- |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
--        |___/|_|
--
-- Hyprland (Lua) + Noctalia v5

local mainMod = "SUPER"

------------------
---- MONITORS ----
------------------

hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@59.98Hz",
	position = "0x0",
	scale = 1,
})

-- Fallback for any other (external) monitor, placed to the right automatically
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

----------------------
---- SOURCE FILES ----
----------------------

-- `source = *.conf` does not work in Lua configs; each file is a .lua module.
-- colors.lua now returns a table, so keep it in a local.
local c = require("colors")
require("keyboard")
require("keybindings")
require("noctalia")

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	-- Noctalia v5 (bar, launcher, notifications, lock screen, wallpaper)
	hl.exec_cmd("noctalia")

	-- XDG desktop portal activation
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

	-- Polkit agent for GUI privilege prompts (skip if Noctalia ships one)
	hl.exec_cmd("systemctl --user start hyprpolkitagent")

	-- Probably redundant with Noctalia's network/bluetooth panels.
	-- Uncomment if you want the tray applets back:
	-- hl.exec_cmd("nm-applet --indicator")
	-- hl.exec_cmd("blueman-applet")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,

		-- Palette from colors.lua (adjust if the Lua API wants a different shape)
		col = {
			active_border = { colors = { c.primary, c.secondary }, angle = 45 },
			inactive_border = c.outline_variant,
		},
	},

	decoration = {
		rounding = 20,
		rounding_power = 2,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 2,
			vibrancy = 0.1696,
		},
	},

	misc = {
		disable_hyprland_logo = true,
		force_default_wallpaper = 0,
	},
})

--------------------
---- LAYER RULES ---
--------------------

-- Blur for Noctalia's bar, panels, dock, notifications, OSD and window switcher.
-- no_anim stops Hyprland's layer animations from clashing with Noctalia's own.
hl.layer_rule({
	name = "noctalia",
	match = { namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$" },
	no_anim = true,
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})

--------------------
---- WINDOW RULES --
--------------------

-- Floating Noctalia settings window
hl.window_rule({
	match = { class = "dev.noctalia.Noctalia" },
	float = true,
	center = true,
	size = { 1080, 920 },
})
