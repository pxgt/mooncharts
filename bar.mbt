// Vertical bar chart.

///|
/// Render a vertical bar chart as a standalone SVG document string.
///
/// `data` is a list of `(label, value)` pairs; values are expected to be
/// non-negative and the tallest bar fills the plot area. `title`, `width`,
/// `height` and `theme` are optional.
pub fn bar_chart(
  data : Array[(String, Double)],
  title? : String = "",
  width? : Double = 480.0,
  height? : Double = 320.0,
  theme? : Theme = Theme::light(),
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
  let (axis_lo, axis_hi, ticks) = nice_ticks(0.0, max, 5)
  let n = data.length()
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  // Gridlines and y-axis labels sit behind the bars.
  body.write_string(
    y_axis(theme, left, top, plot_w, plot_h, axis_lo, axis_hi, ticks),
  )
  if n > 0 {
    let slot = plot_w / n.to_double()
    let bar_w = slot * 0.62
    for i in 0..<n {
      let (name, value) = data[i]
      let bar_h = value / axis_hi * plot_h
      let x = left + slot * i.to_double() + (slot - bar_w) / 2.0
      let y = top + plot_h - bar_h
      // The bar itself.
      body.write_string(
        elem("rect", [
          ("x", num(x)),
          ("y", num(y)),
          ("width", num(bar_w)),
          ("height", num(bar_h)),
          ("fill", theme.color_at(i)),
          ("rx", "2"),
        ]),
      )
      // Value printed just above the bar.
      body.write_string(
        label(x + bar_w / 2.0, y - 6.0, num(value), fill=theme.text),
      )
      // Category label below the baseline.
      body.write_string(
        label(x + bar_w / 2.0, top + plot_h + 16.0, name, fill=theme.text),
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
/// Render a grouped bar chart: for each category, one bar per series, drawn
/// side by side, with a legend. `categories` names the groups along the x-axis;
/// `series` is a list of `(name, values)` pairs where `values[i]` is the value
/// for category `i`. `title`, `width`, `height` and `theme` are optional.
pub fn bar_chart_grouped(
  categories : Array[String],
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
  let bottom = 48.0
  let plot_w = width - left - right
  let plot_h = height - top - bottom
  // Largest value across every series sets the vertical scale.
  let mut raw_max = 0.0
  for s in series {
    for v in s.1 {
      if v > raw_max {
        raw_max = v
      }
    }
  }
  let max = if raw_max <= 0.0 { 1.0 } else { raw_max }
  let (axis_lo, axis_hi, ticks) = nice_ticks(0.0, max, 5)
  let n_cat = categories.length()
  let n_ser = series.length()
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  body.write_string(
    y_axis(theme, left, top, plot_w, plot_h, axis_lo, axis_hi, ticks),
  )
  if n_cat > 0 && n_ser > 0 {
    let slot = plot_w / n_cat.to_double()
    let group_w = slot * 0.7
    let bar_w = group_w / n_ser.to_double()
    for c in 0..<n_cat {
      let group_x = left + slot * c.to_double() + (slot - group_w) / 2.0
      for s in 0..<n_ser {
        let values = series[s].1
        let value = if c < values.length() { values[c] } else { 0.0 }
        let bar_h = value / axis_hi * plot_h
        let x = group_x + bar_w * s.to_double()
        let y = top + plot_h - bar_h
        body.write_string(
          elem("rect", [
            ("x", num(x)),
            ("y", num(y)),
            ("width", num(bar_w)),
            ("height", num(bar_h)),
            ("fill", theme.color_at(s)),
            ("rx", "1"),
          ]),
        )
      }
      // Category label centered under the group.
      body.write_string(
        label(
          group_x + group_w / 2.0,
          top + plot_h + 16.0,
          categories[c],
          fill=theme.text,
        ),
      )
    }
  }
  // Legend of series names.
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

///|
/// Render a stacked bar chart: for each category the series values are stacked
/// into one bar, with a legend. `categories` names the bars; `series` is a list
/// of `(name, values)` where `values[i]` is the value for category `i`.
/// `title`, `width`, `height` and `theme` are optional.
pub fn bar_chart_stacked(
  categories : Array[String],
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
  let bottom = 48.0
  let plot_w = width - left - right
  let plot_h = height - top - bottom
  let n_cat = categories.length()
  let n_ser = series.length()
  // The tallest stacked total sets the vertical scale.
  let mut raw_max = 0.0
  for c in 0..<n_cat {
    let mut total = 0.0
    for s in 0..<n_ser {
      let vals = series[s].1
      if c < vals.length() {
        total = total + vals[c]
      }
    }
    if total > raw_max {
      raw_max = total
    }
  }
  let max = if raw_max <= 0.0 { 1.0 } else { raw_max }
  let (axis_lo, axis_hi, ticks) = nice_ticks(0.0, max, 5)
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  body.write_string(
    y_axis(theme, left, top, plot_w, plot_h, axis_lo, axis_hi, ticks),
  )
  if n_cat > 0 && n_ser > 0 {
    let slot = plot_w / n_cat.to_double()
    let bar_w = slot * 0.6
    for c in 0..<n_cat {
      let x = left + slot * c.to_double() + (slot - bar_w) / 2.0
      let mut acc = 0.0 // value accumulated from the baseline up
      for s in 0..<n_ser {
        let vals = series[s].1
        let value = if c < vals.length() { vals[c] } else { 0.0 }
        if value > 0.0 {
          let seg_h = value / axis_hi * plot_h
          let y = top + plot_h - acc / axis_hi * plot_h - seg_h
          body.write_string(
            elem("rect", [
              ("x", num(x)),
              ("y", num(y)),
              ("width", num(bar_w)),
              ("height", num(seg_h)),
              ("fill", theme.color_at(s)),
            ]),
          )
          acc = acc + value
        }
      }
      body.write_string(
        label(
          x + bar_w / 2.0,
          top + plot_h + 16.0,
          categories[c],
          fill=theme.text,
        ),
      )
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
