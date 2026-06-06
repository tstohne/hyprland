-- -----------------------------------------------------
-- Key bindings
-- name: "Default"
-- -----------------------------------------------------

local mainMod    = "SUPER"
local HYPRSCRIPTS = "~/.config/hypr/scripts"
local SCRIPTS     = "~/.config/ml4w/scripts"

-- =====================================================
-- Applications
-- =====================================================

hl.bind(mainMod .. " + RETURN",    hl.dsp.exec_cmd("kitty"))                                    -- Open the terminal
hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd("/opt/thorium-browser/thorium"))             -- Open the browser
hl.bind(mainMod .. " + F",         hl.dsp.exec_cmd("thunar"))                                   -- Open the filemanager
hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd("emacsclient -r -a=''"))                     -- Start Emacs
hl.bind(mainMod .. " + CTRL + E",  hl.dsp.exec_cmd(SCRIPTS .. "/emojipicker.sh"))               -- Open the emoji picker  (ml4w path)
hl.bind(mainMod .. " + CTRL + C",  hl.dsp.exec_cmd("galculator"))                              -- Open the calculator

-- =====================================================
-- Windows
-- =====================================================

hl.bind(mainMod .. " + Q",          hl.dsp.window.close())                                      -- Kill active window
hl.bind(mainMod .. " + SHIFT + Q",  hl.dsp.exec_cmd(                                            -- Quit active window + all instances
    "hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"))
hl.bind(mainMod .. " + ALT + F",    hl.dsp.window.fullscreen(0))                                -- True fullscreen
hl.bind(mainMod .. " + M",          hl.dsp.window.fullscreen(1))                                -- Maximize window
hl.bind(mainMod .. " + T",          hl.dsp.window.float({ action = "toggle" }))                 -- Toggle floating
hl.bind(mainMod .. " + SHIFT + T",  hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allfloat")) -- Toggle all windows floating (no hl.dsp.* equivalent yet)
hl.bind(mainMod .. " + J",          hl.dsp.layout("togglesplit"))                               -- Toggle split
hl.bind(mainMod .. " + left",       hl.dsp.focus({ direction = "l" }))                         -- Move focus left
hl.bind(mainMod .. " + right",      hl.dsp.focus({ direction = "r" }))                         -- Move focus right
hl.bind(mainMod .. " + up",         hl.dsp.focus({ direction = "u" }))                         -- Move focus up
hl.bind(mainMod .. " + down",       hl.dsp.focus({ direction = "d" }))                         -- Move focus down

hl.bind(mainMod .. " + mouse:272",  hl.dsp.window.drag(),   { mouse = true })                  -- Move window with mouse
hl.bind(mainMod .. " + mouse:273",  hl.dsp.window.resize(), { mouse = true })                  -- Resize window with mouse

hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x =  100, y =    0, relative = true }))  -- Increase width
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -100, y =    0, relative = true }))  -- Reduce width
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x =    0, y =  100, relative = true }))  -- Increase height
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x =    0, y = -100, relative = true }))  -- Reduce height

hl.bind(mainMod .. " + G",         hl.dsp.group.toggle())                                       -- Toggle window group
hl.bind(mainMod .. " + K",         hl.dsp.layout("swapsplit"))                                  -- Swapsplit  -- verify dispatcher
hl.bind(mainMod .. " + ALT + left",  hl.dsp.window.swap({ direction = "l" }))                  -- Swap tiled window left
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "r" }))                  -- Swap tiled window right
hl.bind(mainMod .. " + ALT + up",    hl.dsp.window.swap({ direction = "u" }))                  -- Swap tiled window up
hl.bind(mainMod .. " + ALT + down",  hl.dsp.window.swap({ direction = "d" }))                  -- Swap tiled window down

-- Alt+Tab: cycle windows and bring active to top
hl.bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())    -- Cycle between windows
    hl.dispatch(hl.dsp.window.bring_to_top())  -- Bring active window to top
end, { repeating = true })

-- =====================================================
-- Actions
-- =====================================================

hl.bind(mainMod .. " + CTRL + R",    hl.dsp.exec_cmd("hyprctl reload"))                        -- Reload Hyprland configuration
hl.bind(mainMod .. " + SHIFT + A",   hl.dsp.exec_cmd(HYPRSCRIPTS .. "/toggle-animations.sh"))  -- Toggle animations
hl.bind(mainMod .. " + PRINT",       hl.dsp.exec_cmd(HYPRSCRIPTS .. "/screenshot.sh"))         -- Take a screenshot
hl.bind(mainMod .. " + SHIFT + S",   hl.dsp.exec_cmd(HYPRSCRIPTS .. "/screenshot.sh"))         -- Take a screenshot
hl.bind(mainMod .. " + CTRL + Q",    hl.dsp.exec_cmd(SCRIPTS .. "/wlogout.sh"))                 -- Start wlogout
hl.bind(mainMod .. " + SHIFT + W",   hl.dsp.exec_cmd("waypaper --random"))                     -- Change the wallpaper
hl.bind(mainMod .. " + CTRL + W",    hl.dsp.exec_cmd("waypaper"))                              -- Open wallpaper selector
hl.bind(mainMod .. " + ALT + W",     hl.dsp.exec_cmd(HYPRSCRIPTS .. "/wallpaper-automation.sh")) -- Random wallpaper script
hl.bind(mainMod .. " + CTRL + RETURN", hl.dsp.exec_cmd("pkill rofi || rofi -show drun -replace -i")) -- App launcher
hl.bind(mainMod .. " + CTRL + K",    hl.dsp.exec_cmd(HYPRSCRIPTS .. "/keybindings.sh"))        -- Show keybindings
hl.bind(mainMod .. " + SHIFT + B",   hl.dsp.exec_cmd("~/.config/waybar/launch.sh"))            -- Reload waybar
hl.bind(mainMod .. " + CTRL + B",    hl.dsp.exec_cmd("~/.config/waybar/toggle.sh"))            -- Toggle waybar
hl.bind(mainMod .. " + SHIFT + R",   hl.dsp.exec_cmd(HYPRSCRIPTS .. "/loadconfig.sh"))         -- Reload hyprland config
hl.bind(mainMod .. " + V",           hl.dsp.exec_cmd(SCRIPTS .. "/cliphist.sh"))               -- Open clipboard manager
hl.bind(mainMod .. " + CTRL + T",    hl.dsp.exec_cmd("~/.config/waybar/themeswitcher.sh"))     -- Waybar theme switcher
hl.bind(mainMod .. " + CTRL + S",    hl.dsp.exec_cmd("flatpak run com.ml4w.settings"))         -- ML4W Dotfiles Settings
hl.bind(mainMod .. " + SHIFT + H",   hl.dsp.exec_cmd(HYPRSCRIPTS .. "/hyprshade.sh"))          -- Toggle screenshader
hl.bind(mainMod .. " + ALT + G",     hl.dsp.exec_cmd(HYPRSCRIPTS .. "/gamemode.sh"))           -- Toggle game mode
hl.bind(mainMod .. " + CTRL + L",    hl.dsp.exec_cmd("~/.config/hypr/scripts/power.sh lock"))  -- Lock screen

-- =====================================================
-- Workspaces
-- =====================================================

-- Switch and move to workspace 1-10
for i = 1, 10 do
    local key = i % 10  -- workspace 10 uses key 0
    hl.bind(mainMod .. " + " .. key,           hl.dsp.focus({ workspace = i }))         -- Open workspace
    hl.bind(mainMod .. " + SHIFT + " .. key,   hl.dsp.window.move({ workspace = i }))  -- Move window to workspace
end

-- Move all windows via script (CTRL + 1-10)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + CTRL + " .. key,
        hl.dsp.exec_cmd(HYPRSCRIPTS .. "/moveTo.sh " .. i))
end

hl.bind(mainMod .. " + Tab",         hl.dsp.focus({ workspace = "m+1" }))  -- Next workspace
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }))  -- Previous workspace

hl.bind(mainMod .. " + mouse_down",  hl.dsp.focus({ workspace = "e+1" }))  -- Next workspace (scroll)
hl.bind(mainMod .. " + mouse_up",    hl.dsp.focus({ workspace = "e-1" }))  -- Prev workspace (scroll)
hl.bind(mainMod .. " + CTRL + down", hl.dsp.focus({ workspace = "empty" })) -- Next empty workspace

-- =====================================================
-- Fn keys
-- =====================================================

hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -q s +10%"))                                                 -- Brightness +10%
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -q s 10%-"))                                                 -- Brightness -10%
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ +5%"))  -- Volume +5%
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ -5%"))  -- Volume -5%
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))                               -- Toggle mute
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"))                                                    -- Play/pause
hl.bind("XF86AudioPause",        hl.dsp.exec_cmd("playerctl pause"))                                                         -- Pause
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"))                                                          -- Next track
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"))                                                      -- Prev track
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))                           -- Toggle mic
hl.bind("XF86Calculator",        hl.dsp.exec_cmd("~/.config/ml4w/settings/calculator.sh"))                                   -- Open calculator
hl.bind("XF86ScreenSaver",       hl.dsp.exec_cmd("hyprlock"))                                                                -- Screen lock (XF86Lock → XF86ScreenSaver in xkbcommon)
hl.bind("XF86Tools",             hl.dsp.exec_cmd("flatpak run com.ml4w.settings"))                                           -- ML4W Settings

hl.bind("code:238",              hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s +10"))  -- Keyboard backlight +
hl.bind("code:237",              hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s 10-"))  -- Keyboard backlight -
