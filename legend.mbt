// A horizontal, centered legend shared by the multi-series charts.

///|
/// Render a horizontal legend of `(name, color)` items, centered on `center_x`
/// with text baseline at `y`. Item widths are estimated from the label length,
/// which is good enough for the short series names a legend carries.
fn legend_horizontal(
  items : Array[(String, String)],
  center_x : Double,
  y : Double,
  text_color : String,
) -> String {
  let swatch = 11.0
  let gap = 6.0 // swatch-to-text gap
  let item_gap = 18.0 // gap between items
  let char_w = 6.5 // approximate glyph width at font-size 11
  // Total width so the row can be centered.
  let mut total = 0.0
  for it in items {
    let (name, _) = it
    total += swatch + gap + name.length().to_double() * char_w + item_gap
  }
  if items.length() > 0 {
    total -= item_gap // no trailing gap
  }
  let mut x = center_x - total / 2.0
  let body = StringBuilder::new()
  for it in items {
    let (name, color) = it
    body.write_string(
      elem("rect", [
        ("x", num(x)),
        ("y", num(y - swatch + 2.0)),
        ("width", num(swatch)),
        ("height", num(swatch)),
        ("fill", color),
        ("rx", "2"),
      ]),
    )
    body.write_string(
      label(x + swatch + gap, y, name, anchor="start", fill=text_color),
    )
    x += swatch + gap + name.length().to_double() * char_w + item_gap
  }
  body.to_string()
}
