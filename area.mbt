// XY area chart: a line chart with the region beneath the line filled.

///|
/// Render an area chart for a series of `(x, y)` points as a standalone SVG
/// document string. The region between the line and the baseline is filled
/// with a translucent color; `smooth` curves the top edge; `x_title` /
/// `y_title` add axis captions. `title`, `width`, `height` and `theme` are
/// optional.
pub fn area_chart(
  data : Array[(Double, Double)],
  smooth? : Bool = false,
  x_title? : String = "",
  y_title? : String = "",
  title? : String = "",
  width? : Double = 480.0,
  height? : Double = 320.0,
  theme? : Theme = Theme::light(),
) -> String {
  let left = if y_title == "" { 48.0 } else { 64.0 }
  let right = 16.0
  let top = if title == "" { 16.0 } else { 40.0 }
  let bottom = if x_title == "" { 40.0 } else { 56.0 }
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
    let coords : Array[(Double, Double)] = []
    for i in 0..<n {
      let (x, y) = data[i]
      let px = scale_linear(x, xlo, xhi, left, left + plot_w)
      let py = scale_linear(y, axis_lo, axis_hi, baseline, top)
      px_arr.push(px)
      py_arr.push(py)
      coords.push((px, py))
      if i > 0 {
        line_pts.write_string(" ")
      }
      line_pts.write_string(num(px) + "," + num(py))
    }
    if smooth {
      // One smooth path for the fill (closed to the baseline), one for the
      // top edge.
      let curve = smooth_path(coords)
      let fill_d = curve +
        " L " +
        num(px_arr[n - 1]) +
        " " +
        num(baseline) +
        " L " +
        num(px_arr[0]) +
        " " +
        num(baseline) +
        " Z"
      body.write_string(
        elem("path", [("d", fill_d), ("fill", color), ("fill-opacity", "0.18")]),
      )
      body.write_string(
        elem("path", [
          ("d", curve),
          ("fill", "none"),
          ("stroke", color),
          ("stroke-width", "2"),
          ("stroke-linejoin", "round"),
          ("stroke-linecap", "round"),
        ]),
      )
    } else {
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
    }
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
  body.write_string(
    axis_titles(theme, left, top, plot_w, plot_h, x_title, y_title),
  )
  if title != "" {
    body.write_string(
      label(width / 2.0, 24.0, title, size=16, weight="bold", fill=theme.title),
    )
  }
  document(width, height, body.to_string())
}

///|
/// Render a stacked area chart as a standalone SVG document string: series
/// values at shared `xs` positions are accumulated so each layer sits on top
/// of the one below, with a legend. `series` is a list of `(name, values)`
/// where `values[i]` pairs with `xs[i]`. `title`, `width`, `height` and
/// `theme` are optional.
pub fn area_chart_stacked(
  xs : Array[Double],
  series : Array[(String, Array[Double])],
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
  let n = xs.length()
  let n_ser = series.length()
  // The tallest stacked total sets the y scale.
  let mut max_total = 0.0
  for i in 0..<n {
    let mut total = 0.0
    for s in 0..<n_ser {
      let vals = series[s].1
      if i < vals.length() {
        total += vals[i]
      }
    }
    if total > max_total {
      max_total = total
    }
  }
  let max_total = if max_total <= 0.0 { 1.0 } else { max_total }
  let (axis_lo, axis_hi, ticks) = nice_ticks(0.0, max_total, 5)
  let (xlo_raw, xhi_raw) = extent(xs)
  let (xlo, xhi, x_ticks) = nice_ticks(xlo_raw, xhi_raw, 6)
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  body.write_string(
    y_axis(theme, left, top, plot_w, plot_h, axis_lo, axis_hi, ticks),
  )
  body.write_string(x_axis(theme, left, top, plot_w, plot_h, xlo, xhi, x_ticks))
  if n > 0 && n_ser > 0 {
    let px = fn(x : Double) -> Double {
      scale_linear(x, xlo, xhi, left, left + plot_w)
    }
    let py = fn(v : Double) -> Double {
      scale_linear(v, axis_lo, axis_hi, top + plot_h, top)
    }
    // Running top of the layers already drawn.
    let prev : Array[Double] = []
    for _i in 0..<n {
      prev.push(0.0)
    }
    for s in 0..<n_ser {
      let vals = series[s].1
      let cur : Array[Double] = []
      for i in 0..<n {
        let v = if i < vals.length() { vals[i] } else { 0.0 }
        cur.push(prev[i] + v)
      }
      let color = theme.color_at(s)
      // Band polygon: this layer's top forward, the previous top backward.
      let poly = StringBuilder::new()
      let line_pts = StringBuilder::new()
      for i in 0..<n {
        if i > 0 {
          poly.write_string(" ")
          line_pts.write_string(" ")
        }
        let pt = num(px(xs[i])) + "," + num(py(cur[i]))
        poly.write_string(pt)
        line_pts.write_string(pt)
      }
      for i = n - 1; i >= 0; i = i - 1 {
        poly.write_string(" " + num(px(xs[i])) + "," + num(py(prev[i])))
      }
      body.write_string(
        elem("polygon", [
          ("points", poly.to_string()),
          ("fill", color),
          ("fill-opacity", "0.4"),
        ]),
      )
      // Crisp line along this layer's top edge.
      body.write_string(
        elem("polyline", [
          ("points", line_pts.to_string()),
          ("fill", "none"),
          ("stroke", color),
          ("stroke-width", "1.5"),
        ]),
      )
      for i in 0..<n {
        prev[i] = cur[i]
      }
    }
  }
  let legend_items : Array[(String, String)] = []
  for s in 0..<n_ser {
    legend_items.push((series[s].0, theme.color_at(s)))
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
