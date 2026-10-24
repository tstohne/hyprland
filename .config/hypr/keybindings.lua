-- -----------------------------------------------------
-- Key bindings
-- name: "Default"
-- -----------------------------------------------------

local mainMod = "SUPER"

-- Bind flag presets (old bindel / bindl equivalents)
local repeat_locked = { repeating = true, locked = true } -- volume, brightness
local locked = { locked = true } -- media keys, mute

-- =====================================================
-- Applications
-- =====================================================

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty")) -- Open the terminal
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("/opt/thorium-browser/thorium")) -- Open the browser
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("thunar")) -- Open the filemanager
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("emacsclient -r -a ''")) -- Start Emacs
hl.bind(mainMod .. " + CTRL + C", hl.dsp.exec_cmd("galculator")) -- Open the calculator

-- =====================================================
-- Noctalia
-- =====================================================

hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("noctalia msg plugin noctalia/screen_recorder:service all toggle")) -- Start/stop screen recording
hl.bind(
	mainMod .. " + SHIFT + R",
	hl.dsp.exec_cmd("noctalia msg plugin noctalia/screen_recorder:service all replay-save")
) -- Save replay buffer

-- =====================================================
-- Screenshots (needs grim, slurp, wl-clipboard)
-- =====================================================

hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy')) -- Region screenshot to clipboard
hl.bind(
	"SHIFT + Print",
	hl.dsp.exec_cmd(
		'mkdir -p ~/Pictures/Screenshots && grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png'
	)
) -- Region screenshot to file

-- =====================================================
-- Windows
-- =====================================================

hl.bind(mainMod .. " + Q", hl.dsp.window.close()) -- Close active window
hl.bind(
	mainMod .. " + SHIFT + Q",
	hl.dsp.exec_cmd("hyprctl activewindow -j | jq -r .pid | xargs kill") -- Kill active window's process (needs jq)
)
hl.bind(mainMod .. " + ALT + F", hl.dsp.window.fullscreen(0)) -- True fullscreen
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen(1)) -- Maximize window
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" })) -- Toggle floating
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allfloat")) -- Toggle all windows floating (no hl.dsp.* equivalent yet)
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- Toggle split
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" })) -- Move focus left
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" })) -- Move focus right
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" })) -- Move focus up
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" })) -- Move focus down

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- Move window with mouse
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- Resize window with mouse

hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 100, y = 0, relative = true })) -- Increase width
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -100, y = 0, relative = true })) -- Reduce width
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 100, relative = true })) -- Increase height
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -100, relative = true })) -- Reduce height

hl.bind(mainMod .. " + G", hl.dsp.group.toggle()) -- Toggle window group
hl.bind(mainMod .. " + K", hl.dsp.layout("swapsplit")) -- Swapsplit (verify dispatcher)
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.swap({ direction = "l" })) -- Swap tiled window left
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "r" })) -- Swap tiled window right
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.swap({ direction = "u" })) -- Swap tiled window up
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.swap({ direction = "d" })) -- Swap tiled window down

-- Alt+Tab: cycle windows and bring active to top
-- (Noctalia has a window switcher; check `noctalia msg` and replace this if you prefer it)
hl.bind("ALT + Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next()) -- Cycle between windows
	hl.dispatch(hl.dsp.window.bring_to_top()) -- Bring active window to top
end, { repeating = true })

-- =====================================================
-- Actions
-- =====================================================

hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd("hyprctl reload")) -- Reload Hyprland configuration
-- Rofi launcher removed: Noctalia's launcher is on SUPER+Space (see hyprland.lua).
-- hl.bind(mainMod .. " + CTRL + RETURN", hl.dsp.exec_cmd("pkill rofi || rofi -show drun -replace -i"))

-- =====================================================
-- Workspaces
-- =====================================================

-- Switch and move to workspace 1-10
for i = 1, 10 do
	local key = i % 10 -- workspace 10 uses key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i })) -- Open workspace
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i })) -- Move window to workspace
end

hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "m+1" })) -- Next workspace
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" })) -- Previous workspace

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" })) -- Next workspace (scroll)
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" })) -- Prev workspace (scroll)
hl.bind(mainMod .. " + CTRL + down", hl.dsp.focus({ workspace = "empty" })) -- Next empty workspace

-- =====================================================
-- Fn keys
-- =====================================================

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -q s +10%"), repeat_locked) -- Brightness +10%
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -q s 10%-"), repeat_locked) -- Brightness -10%
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ +5%"),
	repeat_locked
) -- Volume +5%
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ -5%"),
	repeat_locked
) -- Volume -5%
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), locked) -- Toggle mute
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), locked) -- Play/pause
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"), locked) -- Pause
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), locked) -- Next track
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), locked) -- Prev track
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), locked) -- Toggle mic
hl.bind("XF86Calculator", hl.dsp.exec_cmd("~/.config/ml4w/settings/calculator.sh")) -- Open calculator (ml4w path, verify)
hl.bind("XF86ScreenSaver", hl.dsp.exec_cmd("hyprlock")) -- Screen lock (swap for a Noctalia lock command if it has one)
hl.bind("XF86Tools", hl.dsp.exec_cmd("flatpak run com.ml4w.settings")) -- ML4W Settings (remove if ML4W is gone)

hl.bind("code:238", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s +10"), repeat_locked) -- Keyboard backlight +
hl.bind("code:237", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s 10-"), repeat_locked) -- Keyboard backlight -
