-- ~/.config/hypr/noctalia.lua
-- Hyprland (Lua config, 0.55+) side of the Noctalia setup.
-- Load it from hyprland.lua with:  require("noctalia")
-- (adjust the require path to match how your other modules are loaded)
--
-- Before adding the binds, grep your existing keybindings module for
-- SUPER+Space, SUPER+S, SUPER+comma and ALT+Tab, and delete any duplicates.

-- Blur only works if Hyprland's own blur is on. Make sure your hl.config({})
-- has decoration.blur.enabled = true (docs suggest size = 3, passes = 2).

-- ── Persistent workspaces ───────────────────────────────────────
-- Names are what the Noctalia workspaces widget shows (label_source = "name").
-- On a multi-monitor setup add: monitor = "<name from `hyprctl monitors`>"

hl.workspace_rule({ workspace = "1", monitor = "eDP-1", persistent = true, default_name = "Web" })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1", persistent = true, default_name = "Term" })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1", persistent = true, default_name = "Emacs" })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1", persistent = true, default_name = "Chat" })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1", persistent = true, default_name = "Etc" })

-- ── App → workspace placement ───────────────────────────────────
hl.window_rule({ match = { class = "^(Thorium-browser)$" }, workspace = "1" })
hl.window_rule({ match = { class = "^(kitty)$" }, workspace = "2" })
hl.window_rule({ match = { class = "^(/usr/bin/emacsclient -r -a '')$" }, workspace = "3" })
hl.window_rule({ match = { class = "^(mattermost-desktop)$" }, workspace = "4" })

-- ── Autostart ───────────────────────────────────────────────────
hl.on("hyprland.start", function()
	hl.exec_cmd("thorium-browser")
	hl.exec_cmd("kitty")
	hl.exec_cmd("sh -c 'sleep 3; /usr/bin/emacsclient -r -a ''")
	hl.exec_cmd("mattermost-desktop")
end)

-- ── IPC keybinds ────────────────────────────────────────────────
local mainMod = "SUPER"
local ipc = "noctalia msg "

-- Core
hl.bind(mainMod .. "+Space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. "+S", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
hl.bind(mainMod .. "+comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher hold"))

-- Media / hardware keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"))

-- Optional extras (uncomment and pick free key combos)
-- hl.bind(mainMod .. "+L", hl.dsp.exec_cmd(ipc .. "session lock"))
-- hl.bind(mainMod .. "+D", hl.dsp.exec_cmd(ipc .. "dock-toggle"))
-- hl.bind(mainMod .. "+B", hl.dsp.exec_cmd(ipc .. "bar-toggle"))

-- Noctalia Settings window: float it at a sensible size
hl.window_rule({
	match = { class = "dev.noctalia.Noctalia" },
	float = true,
	size = { 1080, 920 },
})

-- ── Blur for bar, panels, dock, notifications (and OSD / switcher) ──
-- no_anim disables Hyprland's own layer animations so they don't fight
-- Noctalia's animations.
hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
	},
	no_anim = true,
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})
