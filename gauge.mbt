// Radial gauge (speedometer): a value shown as a needle over a colored arc.

///|
/// SVG arc path from angle `a0` to `a1` (radians) along a circle of radius
/// `r` centered at `(cx, cy)`.
fn gauge_arc(
  cx : Double,
  cy : Double,
  r : Double,
  a0 : Double,
  a1 : Double,
) -> String {
  let x0 = cx + r * @math.cos(a0)
  let y0 = cy + r * @math.sin(a0)
  let x1 = cx + r * @math.cos(a1)
  let y1 = cy + r * @math.sin(a1)
  let large = if a1 - a0 > @math.PI { "1" } else { "0" }
  "M " +
  num(x0) +
  " " +
  num(y0) +
  " A " +
  num(r) +
  " " +
  num(r) +
  " 0 " +
  large +
  " 1 " +
  num(x1) +
  " " +
  num(y1)
}

///|
/// Render a radial gauge as a standalone SVG document string. The needle
/// points to `value` on a 180° arc spanning `min`..`max`; the arc is split
/// into colored zones by `bands` (each a fraction in `0..1` of the sweep,
/// cycling the palette). `title`, `width`, `height` and `theme` are optional.
pub fn gauge_chart(
  value : Double,
  min? : Double = 0.0,
  max? : Double = 100.0,
  bands? : Array[Double] = [],
  title? : String = "",
  width? : Double = 320.0,
  height? : Double = 220.0,
  theme? : Theme = Theme::light(),
) -> String {
  let cx = width / 2.0
  let cy = height - 42.0
  let r = {
    let by_w = width / 2.0 - 24.0
    let by_h = height - 70.0
    if by_w < by_h {
      by_w
    } else {
      by_h
    }
  }
  // The gauge sweeps the top half, from 180° (left) to 360° (right).
  let start = @math.PI
  let sweep = @math.PI
  let span = if max > min { max - min } else { 1.0 }
  let frac = {
    let f = (value - min) / span
    if f < 0.0 {
      0.0
    } else if f > 1.0 {
      1.0
    } else {
      f
    }
  }
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  // Colored zones, or a single neutral track when no bands are given.
  if bands.length() == 0 {
    body.write_string(
      elem("path", [
        ("d", gauge_arc(cx, cy, r, start, start + sweep)),
        ("fill", "none"),
        ("stroke", theme.grid),
        ("stroke-width", "14"),
        ("stroke-linecap", "round"),
      ]),
    )
  } else {
    let mut acc = 0.0
    for i in 0..<bands.length() {
      let seg = bands[i]
      let a0 = start + sweep * acc
      let a1 = start + sweep * (acc + seg)
      body.write_string(
        elem("path", [
          ("d", gauge_arc(cx, cy, r, a0, a1)),
          ("fill", "none"),
          ("stroke", theme.color_at(i)),
          ("stroke-width", "14"),
        ]),
      )
      acc += seg
    }
  }
  // Needle and hub.
  let angle = start + sweep * frac
  let nx = cx + (r - 6.0) * @math.cos(angle)
  let ny = cy + (r - 6.0) * @math.sin(angle)
  body.write_string(
    elem("line", [
      ("x1", num(cx)),
      ("y1", num(cy)),
      ("x2", num(nx)),
      ("y2", num(ny)),
      ("stroke", theme.text),
      ("stroke-width", "3"),
      ("stroke-linecap", "round"),
    ]),
  )
  body.write_string(
    elem("circle", [
      ("cx", num(cx)),
      ("cy", num(cy)),
      ("r", "6"),
      ("fill", theme.text),
    ]),
  )
  // Numeric readout and end labels.
  body.write_string(
    label(cx, cy - 18.0, num(value), size=22, weight="bold", fill=theme.title),
  )
  body.write_string(
    label(cx - r, cy + 18.0, num(min), size=10, fill=theme.axis),
  )
  body.write_string(
    label(cx + r, cy + 18.0, num(max), size=10, fill=theme.axis),
  )
  if title != "" {
    body.write_string(
      label(width / 2.0, 22.0, title, size=15, weight="bold", fill=theme.title),
    )
  }
  document(width, height, body.to_string())
}
