-- -----------------------------------------------------
-- Keyboard Layout
-- https://wiki.hypr.land/Configuring/Variables/#input
-- -----------------------------------------------------

hl.config({
    input = {
        kb_layout  = "se",
        kb_variant = "",
        kb_model   = "",
        kb_options = "caps:swapescape",

        numlock_by_default = false,
        follow_mouse       = 1,
        mouse_refocus      = false,

        sensitivity = 0, -- Pointer speed: -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
            scroll_factor  = 1.0,  -- Touchpad scroll factor
        },
    },
})
