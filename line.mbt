// XY line chart.

///|
/// Render a line chart connecting a series of `(x, y)` points as a standalone
/// SVG document string. The value axis auto-fits the data with nicely rounded
/// gridlines; when all y-values are positive the baseline is anchored at zero.
/// `title`, `width`, `height` and `theme` are optional.
pub fn line_chart(
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
  // Anchor the baseline at zero for the common all-positive case.
  let ylo = if ylo_raw > 0.0 { 0.0 } else { ylo_raw }
  let (axis_lo, axis_hi, ticks) = nice_ticks(ylo, yhi, 5)
  // The x domain gets nicely rounded ticks too.
  let (xlo, xhi, x_ticks) = nice_ticks(xlo_raw, xhi_raw, 6)
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  body.write_string(
    y_axis(theme, left, top, plot_w, plot_h, axis_lo, axis_hi, ticks),
  )
  body.write_string(x_axis(theme, left, top, plot_w, plot_h, xlo, xhi, x_ticks))
  let n = data.length()
  if n > 0 {
    let color = theme.color_at(0)
    let pts = StringBuilder::new()
    let px_arr : Array[Double] = []
    let py_arr : Array[Double] = []
    for i in 0..<n {
      let (x, y) = data[i]
      let px = scale_linear(x, xlo, xhi, left, left + plot_w)
      let py = scale_linear(y, axis_lo, axis_hi, top + plot_h, top)
      px_arr.push(px)
      py_arr.push(py)
      if i > 0 {
        pts.write_string(" ")
      }
      pts.write_string(num(px) + "," + num(py))
    }
    body.write_string(
      elem("polyline", [
        ("points", pts.to_string()),
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

///|
/// Render several named line series on shared axes with a legend, as a
/// standalone SVG document string. `series` is a list of
/// `(name, points)` pairs where each `points` is a list of `(x, y)`. `title`,
/// `width`, `height` and `theme` are optional.
pub fn line_chart_multi(
  series : Array[(String, Array[(Double, Double)])],
  title? : String = "",
  width? : Double = 520.0,
  height? : Double = 340.0,
  theme? : Theme = Theme::light(),
) -> String {
  let left = 48.0
  let right = 16.0
  let title_h = if title == "" { 8.0 } else { 30.0 }
  let legend_h = 22.0
  let top = title_h + legend_h
  let bottom = 40.0
  let plot_w = width - left - right
  let plot_h = height - top - bottom
  // Domains span every point across all series.
  let all_x : Array[Double] = []
  let all_y : Array[Double] = []
  for s in series {
    for p in s.1 {
      all_x.push(p.0)
      all_y.push(p.1)
    }
  }
  let (xlo_raw, xhi_raw) = extent(all_x)
  let (ylo_raw, yhi) = extent(all_y)
  let ylo = if ylo_raw > 0.0 { 0.0 } else { ylo_raw }
  let (axis_lo, axis_hi, ticks) = nice_ticks(ylo, yhi, 5)
  let (xlo, xhi, x_ticks) = nice_ticks(xlo_raw, xhi_raw, 6)
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  body.write_string(
    y_axis(theme, left, top, plot_w, plot_h, axis_lo, axis_hi, ticks),
  )
  body.write_string(x_axis(theme, left, top, plot_w, plot_h, xlo, xhi, x_ticks))
  for i in 0..<series.length() {
    let points = series[i].1
    let color = theme.color_at(i)
    let pts = StringBuilder::new()
    let coords : Array[(Double, Double)] = []
    for j in 0..<points.length() {
      let (x, y) = points[j]
      let px = scale_linear(x, xlo, xhi, left, left + plot_w)
      let py = scale_linear(y, axis_lo, axis_hi, top + plot_h, top)
      coords.push((px, py))
      if j > 0 {
        pts.write_string(" ")
      }
      pts.write_string(num(px) + "," + num(py))
    }
    body.write_string(
      elem("polyline", [
        ("points", pts.to_string()),
        ("fill", "none"),
        ("stroke", color),
        ("stroke-width", "2"),
        ("stroke-linejoin", "round"),
        ("stroke-linecap", "round"),
      ]),
    )
    for c in coords {
      body.write_string(
        elem("circle", [
          ("cx", num(c.0)),
          ("cy", num(c.1)),
          ("r", "3"),
          ("fill", color),
        ]),
      )
    }
  }
  // Legend of series names.
  let legend_items : Array[(String, String)] = []
  for i in 0..<series.length() {
    legend_items.push((series[i].0, theme.color_at(i)))
  }
  body.write_string(
    legend_horizontal(legend_items, width / 2.0, title_h + 14.0, theme.text),
  )
  if title != "" {
    body.write_string(
      label(width / 2.0, 20.0, title, size=16, weight="bold", fill=theme.title),
    )
  }
  document(width, height, body.to_string())
}
