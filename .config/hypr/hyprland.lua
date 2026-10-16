-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki 

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

require("tablets")
require("windows")
require("monitors")
require("global_keybinds")
local settings = require("settings")

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local taskBar = settings.taskBar
local wallpaper = settings.wallpaper
local notifier = settings.notifier

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function ()
  hl.exec_cmd("uwsm finalize HYPRLAND_INSTANCE_SIGNATURE")
  hl.exec_cmd(taskBar)
  hl.exec_cmd(wallpaper)
  hl.exec_cmd(notifier)
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("easyeffects --gapplication-service")
  hl.exec_cmd("wl-paste --type text --watch cliphist -max-items 100 store")
  hl.exec_cmd("wl-paste --type image --watch cliphist -max-items 100 store")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
  general = {
    gaps_in  = 8,
    gaps_out = 15,

    border_size = 2,

    col = {
      active_border   = { colors = {"rgba(d4be98ff)"} },
      inactive_border = "rgba(45403dff)",
    },

    -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false,

    -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
    allow_tearing = true,
    layout = "scrolling",
  },

  binds = {
    scroll_event_delay = 0,
  },

  decoration = {
    rounding       = 8,
    rounding_power = 2,

    -- Change transparency of focused and unfocused windows
    active_opacity   = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = "0xee1a1a1a",
    },

    blur = {
      enabled   = false,
      size      = 3,
      passes    = 1,
      vibrancy  = 0.1696,
    },
  },

  animations = {
    enabled = true,
  },

  cursor = {
    no_hardware_cursors = false,
    no_warps = true,
  },
})

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
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
    fullscreen_on_one_column = false,
    explicit_column_widths = "0.333, 0.5, 0.667",
    follow_focus = true,
  },
})

----------------
----  MISC  ----
----------------

hl.config({
  misc = {
    force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    focus_on_activate = true,
  },
})

---------------
---- INPUT ----
---------------

hl.config({
  input = {
    kb_layout  = "us",
    kb_variant = "",
    kb_model   = "",
    kb_options = "",
    kb_rules   = "",

    force_no_accel = true,
    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
    accel_profile = "flat",

    follow_mouse = 0,
    float_switch_override_focus = 0,

    touchpad = {
      natural_scroll = false,
    },
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

-- Layouts specific
local layouts = {
  dwindle = "dwindle_layout",
  scrolling = "scrolling",
}
local current_layout = hl.get_config("general.layout")
local l = layouts[current_layout] or layouts.dwindle
require(l)
