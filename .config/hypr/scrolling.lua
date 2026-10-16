require("scrolling_animations")
require("scrolling_keybinds")

hl.on("window.active", function(win)
  if win == nil or win.address == nil or win.floating then return end
  hl.dispatch(hl.dsp.focus({ window = "address:" .. win.address }))
end)
