local settings = require("settings") local mainMod = settings.mainMod

-- unscale XWayland
hl.config({
  xwayland = {
    force_zero_scaling = true
  }
})

hl.config {
  render = {
    direct_scanout = 0,
  }
}

hl.window_rule({
  match = { class = "osu!" },
  fullscreen = true,
  immediate = true,
})

-- Window rules for special float windows 
-- Window Rules for popups
local LANDSCAPE = {900, 560}
local PORTRAIT = {600, 820}
local popups = {
  { name = "pavucontrol-popup", class = "org.pulseaudio.pavucontrol" },
  { name = "blueman-popup", class = "blueman-manager" },
  { name = "nmtui-popup", class = "nmtui-popup", size = PORTRAIT },
  { name = "wlctl-popup", class = "wlctl-popup", size = PORTRAIT },
  { name = "bluetui-popup", class = "bluetui-popup", size = PORTRAIT  },
  { name = "share-picker", class = "hyprland-share-picker" },
}

for _, app in ipairs(popups) do
  hl.window_rule({
    name = app.name,
    match = { class = app.class },

    float = true,
    center = true,
    size = app.size or LANDSCAPE,
  })
end

-- obs
local obs = {
   window = "class:com.obsproject.Studio"
}
hl.bind(mainMod .. " + PAUSE", hl.dsp.pass(obs))

-- NOT MINE

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name  = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize fullscreen",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name  = "fix-xwayland-drags",
  match = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move  = "20 monitor_h-120",
  float = true,
})
