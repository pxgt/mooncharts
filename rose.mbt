// Nightingale rose (polar area) chart: equal-angle sectors whose radius
// encodes value, so area emphasizes larger categories.

///|
/// SVG path for a filled sector (pie slice) from `a0` to `a1` radians at
/// radius `r`, centered at `(cx, cy)`.
fn rose_sector(
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
  num(cx) +
  " " +
  num(cy) +
  " L " +
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
  num(y1) +
  " Z"
}

///|
/// Render a Nightingale rose chart as a standalone SVG document string. Each
/// `(label, value)` gets an equal-angle sector whose radius is proportional to
/// `sqrt(value)` (so sector *area* tracks the value). Concentric guide rings
/// and a legend are drawn. `title`, `width`, `height` and `theme` are optional.
pub fn rose_chart(
  data : Array[(String, Double)],
  title? : String = "",
  width? : Double = 420.0,
  height? : Double = 360.0,
  theme? : Theme = Theme::light(),
) -> String {
  let title_h = if title == "" { 8.0 } else { 30.0 }
  let legend_h = 22.0
  let top = title_h + legend_h
  let n = data.length()
  let cx = width / 2.0
  let cy = top + (height - top) / 2.0
  let radius = {
    let by_h = (height - top - 24.0) / 2.0
    let by_w = width / 2.0 - 90.0
    if by_h < by_w {
      by_h
    } else {
      by_w
    }
  }
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  if n > 0 {
    let mut vmax = 0.0
    for d in data {
      if d.1 > vmax {
        vmax = d.1
      }
    }
    if vmax <= 0.0 {
      vmax = 1.0
    }
    // Concentric guide rings at quarter steps.
    for k in 1..<=4 {
      body.write_string(
        elem("circle", [
          ("cx", num(cx)),
          ("cy", num(cy)),
          ("r", num(radius * k.to_double() / 4.0)),
          ("fill", "none"),
          ("stroke", theme.grid),
          ("stroke-width", "1"),
        ]),
      )
    }
    let step = 2.0 * @math.PI / n.to_double()
    for i in 0..<n {
      let v = if data[i].1 > 0.0 { data[i].1 } else { 0.0 }
      let rr = radius * (v / vmax).sqrt()
      let a0 = -@math.PI / 2.0 + step * i.to_double()
      let a1 = a0 + step
      body.write_string(
        elem("path", [
          ("d", rose_sector(cx, cy, rr, a0, a1)),
          ("fill", theme.color_at(i)),
          ("fill-opacity", "0.8"),
          (
            "stroke",
            if theme.background == "" {
              "#ffffff"
            } else {
              theme.background
            },
          ),
          ("stroke-width", "1"),
        ]),
      )
    }
    // Legend along the bottom-left.
    let legend_items : Array[(String, String)] = []
    for i in 0..<n {
      legend_items.push((data[i].0, theme.color_at(i)))
    }
    body.write_string(
      legend_horizontal(legend_items, width / 2.0, title_h + 14.0, theme.text),
    )
  }
  if title != "" {
    body.write_string(
      label(width / 2.0, 20.0, title, size=16, weight="bold", fill=theme.title),
    )
  }
  document(width, height, body.to_string())
}
