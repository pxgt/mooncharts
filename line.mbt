// XY line chart.

///|
/// Render a line chart connecting a series of `(x, y)` points as a standalone
/// SVG document string. The axes auto-fit the data; when all y-values are
/// positive the baseline is anchored at zero. `title`, `width` and `height`
/// are optional.
pub fn line_chart(
  data : Array[(Double, Double)],
  title? : String = "",
  width? : Double = 480.0,
  height? : Double = 320.0,
) -> String {
  let left = 48.0
  let right = 16.0
  let top = if title == "" { 16.0 } else { 40.0 }
  let bottom = 40.0
  let plot_w = width - left - right
  let plot_h = height - top - bottom
  let xs = data.map(fn(p) { p.0 })
  let ys = data.map(fn(p) { p.1 })
  let (xlo, xhi) = extent(xs)
  let (ylo_raw, yhi) = extent(ys)
  // Anchor the baseline at zero for the common all-positive case.
  let ylo = if ylo_raw > 0.0 { 0.0 } else { ylo_raw }
  let body = StringBuilder::new()
  // Axes: left vertical and bottom horizontal.
  body.write_string(
    elem("line", [
      ("x1", num(left)),
      ("y1", num(top)),
      ("x2", num(left)),
      ("y2", num(top + plot_h)),
      ("stroke", "#cccccc"),
      ("stroke-width", "1"),
    ]),
  )
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
  let n = data.length()
  if n > 0 {
    // Build the polyline point string and remember pixel positions for markers.
    let pts = StringBuilder::new()
    let px_arr : Array[Double] = []
    let py_arr : Array[Double] = []
    for i in 0..<n {
      let (x, y) = data[i]
      let px = scale_linear(x, xlo, xhi, left, left + plot_w)
      let py = scale_linear(y, ylo, yhi, top + plot_h, top)
      px_arr.push(px)
      py_arr.push(py)
      if i > 0 {
        pts.write_string(" ")
      }
      pts.write_string(num(px))
      pts.write_string(",")
      pts.write_string(num(py))
    }
    body.write_string(
      elem("polyline", [
        ("points", pts.to_string()),
        ("fill", "none"),
        ("stroke", color_at(0)),
        ("stroke-width", "2"),
        ("stroke-linejoin", "round"),
        ("stroke-linecap", "round"),
      ]),
    )
    // Markers on each data point.
    for i in 0..<n {
      body.write_string(
        elem("circle", [
          ("cx", num(px_arr[i])),
          ("cy", num(py_arr[i])),
          ("r", "3"),
          ("fill", color_at(0)),
        ]),
      )
    }
  }
  if title != "" {
    body.write_string(
      label(width / 2.0, 24.0, title, size=16, weight="bold", fill="#222222"),
    )
  }
  document(width, height, body.to_string())
}
