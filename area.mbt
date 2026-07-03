// XY area chart: a line chart with the region beneath the line filled.

///|
/// Render an area chart for a series of `(x, y)` points as a standalone SVG
/// document string. The region between the line and the baseline is filled with
/// a translucent color. `title`, `width`, `height` and `theme` are optional.
pub fn area_chart(
  data : Array[(Double, Double)],
  title? : String = "",
  width? : Double = 480.0,
  height? : Double = 320.0,
  theme? : Theme = Theme::light(),
) -> String {
  let left = 48.0
  let right = 16.0
  let top = if title == "" { 16.0 } else { 40.0 }
  let bottom = 40.0
  let plot_w = width - left - right
  let plot_h = height - top - bottom
  let xs = data.map(fn(p) { p.0 })
  let ys = data.map(fn(p) { p.1 })
  let (xlo_raw, xhi_raw) = extent(xs)
  let (ylo_raw, yhi) = extent(ys)
  let ylo = if ylo_raw > 0.0 { 0.0 } else { ylo_raw }
  let (axis_lo, axis_hi, ticks) = nice_ticks(ylo, yhi, 5)
  let (xlo, xhi, x_ticks) = nice_ticks(xlo_raw, xhi_raw, 6)
  let baseline = top + plot_h
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  body.write_string(
    y_axis(theme, left, top, plot_w, plot_h, axis_lo, axis_hi, ticks),
  )
  body.write_string(x_axis(theme, left, top, plot_w, plot_h, xlo, xhi, x_ticks))
  let n = data.length()
  if n > 0 {
    let color = theme.color_at(0)
    let line_pts = StringBuilder::new()
    let px_arr : Array[Double] = []
    let py_arr : Array[Double] = []
    for i in 0..<n {
      let (x, y) = data[i]
      let px = scale_linear(x, xlo, xhi, left, left + plot_w)
      let py = scale_linear(y, axis_lo, axis_hi, baseline, top)
      px_arr.push(px)
      py_arr.push(py)
      if i > 0 {
        line_pts.write_string(" ")
      }
      line_pts.write_string(num(px) + "," + num(py))
    }
    // Filled polygon: along the line, then down to the baseline and back.
    let poly = StringBuilder::new()
    poly.write_string(num(px_arr[0]) + "," + num(baseline) + " ")
    poly.write_string(line_pts.to_string())
    poly.write_string(" " + num(px_arr[n - 1]) + "," + num(baseline))
    body.write_string(
      elem("polygon", [
        ("points", poly.to_string()),
        ("fill", color),
        ("fill-opacity", "0.18"),
      ]),
    )
    body.write_string(
      elem("polyline", [
        ("points", line_pts.to_string()),
        ("fill", "none"),
        ("stroke", color),
        ("stroke-width", "2"),
        ("stroke-linejoin", "round"),
        ("stroke-linecap", "round"),
      ]),
    )
    for i in 0..<n {
      body.write_string(
        elem("circle", [
          ("cx", num(px_arr[i])),
          ("cy", num(py_arr[i])),
          ("r", "3"),
          ("fill", color),
        ]),
      )
    }
  }
  if title != "" {
    body.write_string(
      label(width / 2.0, 24.0, title, size=16, weight="bold", fill=theme.title),
    )
  }
  document(width, height, body.to_string())
}
