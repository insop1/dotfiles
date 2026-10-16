local settings = require("settings")
local mainMod = settings.mainMod -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + H",  hl.dsp.layout("focus left"))
hl.bind(mainMod .. " + L", hl.dsp.layout("focus right"))
hl.bind(mainMod .. " + K",  hl.dsp.layout("focus up"))
hl.bind(mainMod .. " + J", hl.dsp.layout("focus down"))

hl.bind(mainMod .. " + SHIFT + H",  hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + L",  hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + SHIFT + K",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J",  hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + BRACKETLEFT",  hl.dsp.layout("consume_or_expel prev"))
hl.bind(mainMod .. " + BRACKETRIGHT",  hl.dsp.layout("consume_or_expel next"))

hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen_state({internal = 2, client = 0, action = "toggle"}))
hl.bind(mainMod .. " + F", hl.dsp.layout("colresize 1.0"))
hl.bind(mainMod .. " + R", hl.dsp.layout("colresize +conf"))

-- -- Example special workspace (scratchpad)
-- hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

local throttled = false
local function throttled_dsp(dsp)
  return function()
    if throttled then return end
    throttled = true
    hl.dispatch(dsp)
    hl.timer(
      function()
        throttled = false
      end,
      {
        timeout = 200,
        type = "oneshot",
      }
    )
  end
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", throttled_dsp(hl.dsp.layout("focus right")))
hl.bind(mainMod .. " + mouse_up",   throttled_dsp(hl.dsp.layout("focus left")))
