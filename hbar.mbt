// Horizontal bar chart.

///|
/// Render a horizontal bar chart as a standalone SVG document string: one bar
/// per `(label, value)` pair growing rightward, with category labels on the
/// left, value labels at the bar tips, and vertical gridlines. Values are
/// expected to be non-negative. `title`, `width`, `height` and `theme` are
/// optional.
pub fn bar_chart_horizontal(
  data : Array[(String, Double)],
  title? : String = "",
  width? : Double = 480.0,
  height? : Double = 320.0,
  theme? : Theme = Theme::light(),
) -> String {
  let left = 90.0
  let right = 40.0
  let top = if title == "" { 16.0 } else { 40.0 }
  let bottom = 32.0
  let plot_w = width - left - right
  let plot_h = height - top - bottom
  let values = data.map(fn(d) { d.1 })
  let (_, raw_max) = extent(values)
  let max = if raw_max <= 0.0 { 1.0 } else { raw_max }
  let (axis_lo, axis_hi, ticks) = nice_ticks(0.0, max, 5)
  let n = data.length()
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  // Vertical gridlines with value labels along the bottom.
  body.write_string(
    x_axis(theme, left, top, plot_w, plot_h, axis_lo, axis_hi, ticks, grid=true),
  )
  if n > 0 {
    let slot = plot_h / n.to_double()
    let bar_h = slot * 0.62
    for i in 0..<n {
      let (name, value) = data[i]
      let bar_w = scale_linear(value, axis_lo, axis_hi, 0.0, plot_w)
      let y = top + slot * i.to_double() + (slot - bar_h) / 2.0
      body.write_string(
        elem("rect", [
          ("x", num(left)),
          ("y", num(y)),
          ("width", num(bar_w)),
          ("height", num(bar_h)),
          ("fill", theme.color_at(i)),
          ("rx", "2"),
        ]),
      )
      // Category label on the left, value label just past the bar tip.
      body.write_string(
        label(
          left - 8.0,
          y + bar_h / 2.0 + 4.0,
          name,
          anchor="end",
          fill=theme.text,
        ),
      )
      body.write_string(
        label(
          left + bar_w + 6.0,
          y + bar_h / 2.0 + 4.0,
          num(value),
          anchor="start",
          fill=theme.text,
        ),
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
