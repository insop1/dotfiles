local settings = require("settings")
local mainMod = settings.mainMod -- Sets "Windows" key as main modifier

-- Resize
local ratios = { 0.6667, 1.0, 1.3333 }
local idx = {}

hl.bind(mainMod .. " + R", function()
  local win = hl.get_active_window()
  if win == nil or win.floating then return end

  local key = win.address
  idx[key] = (idx[key] or 2) % #ratios + 1
  hl.dispatch(hl.dsp.layout("splitratio " .. ratios[idx[key]] .. " exact"))
end)

hl.on("window.close", function(win)
  idx[win.address] = nil
end)

hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + H",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J",  hl.dsp.window.move({ direction = "down" }))

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
