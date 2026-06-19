// Radar (spider) chart.

///|
/// Angle of axis `i` of `n`, in radians, starting at the top (12 o'clock) and
/// going clockwise.
fn radar_angle(i : Int, n : Int) -> Double {
  -@math.PI / 2.0 + i.to_double() * 2.0 * @math.PI / n.to_double()
}

///|
/// Render a radar (spider) chart: each entry of `axes` becomes a spoke and each
/// series in `series` is drawn as a closed polygon over the spokes. `series` is
/// a list of `(name, values)` where `values[i]` is the value on axis `i`.
/// `title`, `width`, `height` and `theme` are optional.
pub fn radar_chart(
  axes : Array[String],
  series : Array[(String, Array[Double])],
  title? : String = "",
  width? : Double = 460.0,
  height? : Double = 380.0,
  theme? : Theme = Theme::light(),
) -> String {
  let title_h = if title == "" { 8.0 } else { 30.0 }
  let legend_h = 22.0
  let top = title_h + legend_h
  let n = axes.length()
  let cx = width / 2.0
  let cy = top + (height - top) / 2.0
  // Leave room for axis labels around the web.
  let radius = {
    let by_h = (height - top - 36.0) / 2.0
    let by_w = width / 2.0 - 64.0
    if by_h < by_w {
      by_h
    } else {
      by_w
    }
  }
  let mut max = 0.0
  for s in series {
    for v in s.1 {
      if v > max {
        max = v
      }
    }
  }
  if max <= 0.0 {
    max = 1.0
  }
  let (_, axis_hi, ticks) = nice_ticks(0.0, max, 4)
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  if n >= 3 {
    // Concentric grid rings at each tick.
    for t in ticks {
      if t > 0.0 {
        let rr = t / axis_hi * radius
        let ring = StringBuilder::new()
        for i in 0..<n {
          let a = radar_angle(i, n)
          if i > 0 {
            ring.write_string(" ")
          }
          ring.write_string(
            num(cx + rr * @math.cos(a)) + "," + num(cy + rr * @math.sin(a)),
          )
        }
        body.write_string(
          elem("polygon", [
            ("points", ring.to_string()),
            ("fill", "none"),
            ("stroke", theme.grid),
            ("stroke-width", "1"),
          ]),
        )
      }
    }
    // Spokes and axis labels.
    for i in 0..<n {
      let a = radar_angle(i, n)
      body.write_string(
        elem("line", [
          ("x1", num(cx)),
          ("y1", num(cy)),
          ("x2", num(cx + radius * @math.cos(a))),
          ("y2", num(cy + radius * @math.sin(a))),
          ("stroke", theme.grid),
          ("stroke-width", "1"),
        ]),
      )
      let lx = cx + (radius + 16.0) * @math.cos(a)
      let ly = cy + (radius + 16.0) * @math.sin(a) + 4.0
      let anchor = if @math.cos(a) > 0.3 {
        "start"
      } else if @math.cos(a) < -0.3 {
        "end"
      } else {
        "middle"
      }
      body.write_string(label(lx, ly, axes[i], anchor~, fill=theme.axis))
    }
    // One filled polygon per series.
    for si in 0..<series.length() {
      let vals = series[si].1
      let color = theme.color_at(si)
      let poly = StringBuilder::new()
      for i in 0..<n {
        let v = if i < vals.length() { vals[i] } else { 0.0 }
        let rr = v / axis_hi * radius
        let a = radar_angle(i, n)
        if i > 0 {
          poly.write_string(" ")
        }
        poly.write_string(
          num(cx + rr * @math.cos(a)) + "," + num(cy + rr * @math.sin(a)),
        )
      }
      body.write_string(
        elem("polygon", [
          ("points", poly.to_string()),
          ("fill", color),
          ("fill-opacity", "0.15"),
          ("stroke", color),
          ("stroke-width", "2"),
        ]),
      )
    }
  }
  let legend_items : Array[(String, String)] = []
  for si in 0..<series.length() {
    legend_items.push((series[si].0, theme.color_at(si)))
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
