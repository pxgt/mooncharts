// Sparkline: a tiny, axis-less inline trend line. Useful for dashboards and
// tables where the shape matters more than exact values.

///|
/// Render a compact sparkline as a standalone SVG document string: a small
/// polyline through `values` with an optional end-point dot. No axes, labels
/// or padding beyond a thin margin, so it embeds inline. `width`, `height`,
/// `dot` and `theme` are optional.
pub fn sparkline(
  values : Array[Double],
  width? : Double = 120.0,
  height? : Double = 28.0,
  dot? : Bool = true,
  theme? : Theme = Theme::light(),
) -> String {
  let pad = 3.0
  let plot_w = width - pad * 2.0
  let plot_h = height - pad * 2.0
  let n = values.length()
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  if n > 0 {
    let (lo, hi) = extent(values)
    let span = if hi > lo { hi - lo } else { 1.0 }
    let color = theme.color_at(0)
    let pts = StringBuilder::new()
    let mut last_x = pad
    let mut last_y = pad
    for i in 0..<n {
      let x = if n == 1 {
        pad + plot_w / 2.0
      } else {
        pad + plot_w * i.to_double() / (n - 1).to_double()
      }
      // Higher values sit higher on screen (smaller y).
      let y = pad + plot_h * (1.0 - (values[i] - lo) / span)
      if i > 0 {
        pts.write_string(" ")
      }
      pts.write_string(num(x) + "," + num(y))
      last_x = x
      last_y = y
    }
    body.write_string(
      elem("polyline", [
        ("points", pts.to_string()),
        ("fill", "none"),
        ("stroke", color),
        ("stroke-width", "1.5"),
        ("stroke-linejoin", "round"),
        ("stroke-linecap", "round"),
      ]),
    )
    if dot {
      body.write_string(
        elem("circle", [
          ("cx", num(last_x)),
          ("cy", num(last_y)),
          ("r", "2"),
          ("fill", color),
        ]),
      )
    }
  }
  document(width, height, body.to_string())
}
