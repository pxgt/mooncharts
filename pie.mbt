// Pie / donut chart.

///|
/// A point on the circle of radius `r` centered at `(cx, cy)` at `angle`
/// radians (0 = 3 o'clock, increasing clockwise in SVG's y-down space).
fn polar(
  cx : Double,
  cy : Double,
  r : Double,
  angle : Double,
) -> (Double, Double) {
  (cx + r * @math.cos(angle), cy + r * @math.sin(angle))
}

///|
/// SVG path data for one slice from `a0` to `a1`. With `inner <= 0` it is a
/// full wedge from the center; otherwise it is a donut segment between radii
/// `inner` and `r`.
fn arc_path(
  cx : Double,
  cy : Double,
  r : Double,
  inner : Double,
  a0 : Double,
  a1 : Double,
) -> String {
  let (x0, y0) = polar(cx, cy, r, a0)
  let (x1, y1) = polar(cx, cy, r, a1)
  let large = if a1 - a0 > @math.PI { "1" } else { "0" }
  if inner <= 0.0 {
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
  } else {
    let (xi0, yi0) = polar(cx, cy, inner, a0)
    let (xi1, yi1) = polar(cx, cy, inner, a1)
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
    num(y1) +
    " L " +
    num(xi1) +
    " " +
    num(yi1) +
    " A " +
    num(inner) +
    " " +
    num(inner) +
    " 0 " +
    large +
    " 0 " +
    num(xi0) +
    " " +
    num(yi0) +
    " Z"
  }
}

///|
/// Append one slice to `body`, splitting a full-circle slice into two halves so
/// the arc is never degenerate.
fn emit_slice(
  body : StringBuilder,
  cx : Double,
  cy : Double,
  r : Double,
  inner : Double,
  a0 : Double,
  a1 : Double,
  fill : String,
) -> Unit {
  if a1 - a0 >= @math.PI * 2.0 - 0.000001 {
    let mid = a0 + @math.PI
    body.write_string(
      elem("path", [("d", arc_path(cx, cy, r, inner, a0, mid)), ("fill", fill)]),
    )
    body.write_string(
      elem("path", [("d", arc_path(cx, cy, r, inner, mid, a1)), ("fill", fill)]),
    )
  } else {
    body.write_string(
      elem("path", [("d", arc_path(cx, cy, r, inner, a0, a1)), ("fill", fill)]),
    )
  }
}

///|
/// Render a pie chart (or a donut when `donut` is set to an inner-radius ratio
/// in `0.0..1.0`) as a standalone SVG document string. `data` is a list of
/// `(label, value)` pairs; non-positive values are skipped in the ring but
/// still shown in the legend. `title`, `width` and `height` are optional.
pub fn pie_chart(
  data : Array[(String, Double)],
  title? : String = "",
  width? : Double = 380.0,
  height? : Double = 300.0,
  donut? : Double = 0.0,
  theme? : Theme = Theme::light(),
) -> String {
  let top = if title == "" { 16.0 } else { 40.0 }
  let mut total = 0.0
  for d in data {
    if d.1 > 0.0 {
      total += d.1
    }
  }
  if total <= 0.0 {
    total = 1.0
  }
  let cy = top + (height - top) / 2.0
  let mut r = (height - top - 24.0) / 2.0
  let max_r_by_width = (width - 140.0) / 2.0
  if r > max_r_by_width {
    r = max_r_by_width
  }
  let cx = 16.0 + r
  let inner = if donut > 0.0 { r * donut } else { 0.0 }
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  let mut angle = -@math.PI / 2.0
  let n = data.length()
  let item_h = 20.0
  let mut legend_y = cy - n.to_double() * item_h / 2.0 + item_h / 2.0
  let legend_x = cx + r + 20.0
  for i in 0..<n {
    let (name, value) = data[i]
    if value > 0.0 {
      let a0 = angle
      let a1 = angle + value / total * @math.PI * 2.0
      emit_slice(body, cx, cy, r, inner, a0, a1, theme.color_at(i))
      angle = a1
    }
    // Legend swatch and label for every item.
    body.write_string(
      elem("rect", [
        ("x", num(legend_x)),
        ("y", num(legend_y - 9.0)),
        ("width", "12"),
        ("height", "12"),
        ("fill", theme.color_at(i)),
        ("rx", "2"),
      ]),
    )
    body.write_string(
      label(
        legend_x + 18.0,
        legend_y,
        name + " (" + num(value) + ")",
        anchor="start",
        fill=theme.text,
      ),
    )
    legend_y += item_h
  }
  if title != "" {
    body.write_string(
      label(width / 2.0, 24.0, title, size=16, weight="bold", fill=theme.title),
    )
  }
  document(width, height, body.to_string())
}
