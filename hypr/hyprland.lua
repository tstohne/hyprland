--  _   _                  _                 _
-- | | | |_   _ _ __  _ __| | __ _ _ __   __| |
-- | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
-- |  _  | |_| | |_) | |  | | (_| | | | | (_| |
-- |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
--        |___/|_|

-- NOTE: `source = *.conf` cannot be used in Lua configs. Each sourced file
-- must be converted to a .lua file and loaded with require() instead.
-- The three stubs below assume you have renamed/converted them accordingly.

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@59.98Hz",
    position = "0x0",
    scale    = 1,
})

----------------------
---- SOURCE FILES ----
----------------------

-- Keyboard settings  (convert keyboard.conf → keyboard.lua)
require("keyboard")

-- Keybindings        (convert keybindings.conf → keybindings.lua)
require("keybindings")

-- Colors             (convert colors.conf → colors.lua)
require("colors")

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    -- Wallpaper
    hl.exec_cmd("hyprpaper")

    -- Noctalia shell
    hl.exec_cmd("qs -c noctalia-shell")

    -- Network / Bluetooth applets
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("blueman-applet")

    -- XDG desktop portal activation
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Uncomment below if you switch back to Waybar / hypridle:
    -- hl.exec_cmd("pkill waybar; sleep 0.5; waybar")
    -- hl.exec_cmd("hypridle")
    -- hl.exec_cmd("dunst")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("QT_QPA_PLATFORM",                "wayland")
hl.env("QT_QPA_PLATFORMTHEME",           "qt5ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("KWIN_TRIPLE_BUFFER",             "1")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,
    },

    decoration = {
        rounding       = 20,
        rounding_power = 2,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,  -- rgba(1a1a1aee) → ARGB 0xee1a1a1a
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 2,
            vibrancy  = 0.1696,
        },
    },
})

--------------------
---- LAYER RULES ---
--------------------

hl.layer_rule({
    name          = "noctalia",
    match         = { namespace = "noctalia-background-.*$" },
    ignore_alpha  = 0.5,
    blur          = true,
    blur_popups   = true,
})

---------------------
---- KEYBINDINGS ----
---------------------

-- NOTE: $mainMod is defined in keybindings.conf/lua; duplicate here only
-- for the single bind that lived directly in hyprland.conf.

local mainMod = "SUPER"

-- Exit menu
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("~/.config/hypr/scripts/exit-menu.sh"))
