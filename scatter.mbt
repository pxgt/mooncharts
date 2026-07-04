// XY scatter plot.

///|
/// Render a scatter plot of `(x, y)` points as a standalone SVG document
/// string. The y value axis gets nicely rounded gridlines; the x domain is
/// padded slightly so points never sit on the frame. `title`, `width`,
/// `height`, the point `radius` and `theme` are optional.
pub fn scatter_chart(
  data : Array[(Double, Double)],
  errors? : Array[Double] = [],
  title? : String = "",
  width? : Double = 480.0,
  height? : Double = 320.0,
  radius? : Double = 4.0,
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
  let (ylo, yhi) = extent_with_errors(ys, errors)
  let (axis_lo, axis_hi, ticks) = nice_ticks(ylo, yhi, 5)
  // Nicely rounded x ticks; the rounded domain usually already pads the data.
  let (xlo, xhi, x_ticks) = nice_ticks(xlo_raw, xhi_raw, 6)
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  body.write_string(
    y_axis(theme, left, top, plot_w, plot_h, axis_lo, axis_hi, ticks),
  )
  body.write_string(x_axis(theme, left, top, plot_w, plot_h, xlo, xhi, x_ticks))
  let color = theme.color_at(0)
  for i in 0..<data.length() {
    let (x, y) = data[i]
    let px = scale_linear(x, xlo, xhi, left, left + plot_w)
    let py = scale_linear(y, axis_lo, axis_hi, top + plot_h, top)
    // Error bar behind the dot.
    let e = error_at(errors, i)
    if e > 0.0 {
      body.write_string(
        error_bar(
          px,
          scale_linear(y - e, axis_lo, axis_hi, top + plot_h, top),
          scale_linear(y + e, axis_lo, axis_hi, top + plot_h, top),
          8.0,
          color,
        ),
      )
    }
    body.write_string(
      elem("circle", [
        ("cx", num(px)),
        ("cy", num(py)),
        ("r", num(radius)),
        ("fill", color),
        ("fill-opacity", "0.7"),
      ]),
    )
  }
  if title != "" {
    body.write_string(
      label(width / 2.0, 24.0, title, size=16, weight="bold", fill=theme.title),
    )
  }
  document(width, height, body.to_string())
}
