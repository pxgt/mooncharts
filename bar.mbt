// Vertical bar chart.

///|
/// Render a vertical bar chart as a standalone SVG document string.
///
/// `data` is a list of `(label, value)` pairs; values are expected to be
/// non-negative and the tallest bar fills the plot area. `title`, `width` and
/// `height` are optional.
pub fn bar_chart(
  data : Array[(String, Double)],
  title? : String = "",
  width? : Double = 480.0,
  height? : Double = 320.0,
) -> String {
  let left = 48.0
  let right = 16.0
  let top = if title == "" { 16.0 } else { 40.0 }
  let bottom = 48.0
  let plot_w = width - left - right
  let plot_h = height - top - bottom
  // The largest value sets the vertical scale; guard the empty / all-zero case.
  let values = data.map(fn(d) { d.1 })
  let (_, raw_max) = extent(values)
  let max = if raw_max <= 0.0 { 1.0 } else { raw_max }
  let n = data.length()
  let body = StringBuilder::new()
  // Baseline along the bottom of the plot area.
  body.write_string(
    elem("line", [
      ("x1", num(left)),
      ("y1", num(top + plot_h)),
      ("x2", num(left + plot_w)),
      ("y2", num(top + plot_h)),
      ("stroke", "#888888"),
      ("stroke-width", "1"),
    ]),
  )
  if n > 0 {
    let slot = plot_w / n.to_double()
    let bar_w = slot * 0.62
    for i in 0..<n {
      let (name, value) = data[i]
      let bar_h = value / max * plot_h
      let x = left + slot * i.to_double() + (slot - bar_w) / 2.0
      let y = top + plot_h - bar_h
      // The bar itself.
      body.write_string(
        elem("rect", [
          ("x", num(x)),
          ("y", num(y)),
          ("width", num(bar_w)),
          ("height", num(bar_h)),
          ("fill", color_at(i)),
          ("rx", "2"),
        ]),
      )
      // Value printed just above the bar.
      body.write_string(label(x + bar_w / 2.0, y - 6.0, num(value)))
      // Category label below the baseline.
      body.write_string(label(x + bar_w / 2.0, top + plot_h + 16.0, name))
    }
  }
  if title != "" {
    body.write_string(
      label(width / 2.0, 24.0, title, size=16, weight="bold", fill="#222222"),
    )
  }
  document(width, height, body.to_string())
}
