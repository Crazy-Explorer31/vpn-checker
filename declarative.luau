--!nonstrict
-- Declarative bar widget: renders a ui.* tree with barWidget.render() instead
-- of the imperative setText/setGlyph patches (hello.luau). The tree replaces
-- the built-in glyph/text row. Pointer controls (ui.button, ui.toggle, …) work
-- inline and consume their own clicks; the widget-level onClick still fires on
-- the rest of the capsule. Keyboard controls (ui.input/ui.select/ui.scroll)
-- are not available in the bar. The capsule clips to bar thickness, so keep
-- the tree one control tall.

local function render()
  local content = noctalia.readFile("/tmp/v2raya_daemon.state") -- ← ИСПРАВЛЕНО: .state вместо .pid

  -- Если файл пустой или nil
  if not content or content == "" then
    content = "No state"
  end
  -- Stack along the bar: a row in a horizontal bar, a column in a side bar.
  local container = barWidget.isVertical() and ui.column or ui.row
  barWidget.render(container({ gap = 6, align = "center" }, {
    ui.row({ fill = "secondary/0.25", radius = 8, paddingH = 6, align = "center" }, {
      ui.label({ text = "vpn-" .. content, color = "secondary", fontWeight = "bold" }),
    }),
  }))
end

function update()
  noctalia.setUpdateInterval(1000)
  render()
end
