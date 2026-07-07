// Bubble chart: an XY scatter whose third dimension maps to dot area.

///|
/// Render a bubble chart as a standalone SVG document string. Each entry of
/// `data` is `(x, y, size)`; bubble *area* is proportional to `size`, with the
/// largest bubble drawn at `max_radius` pixels. `title`, `width`, `height`
/// and `theme` are optional.
pub fn bubble_chart(
  data : Array[(Double, Double, Double)],
  max_radius? : Double = 22.0,
  title? : String = "",
  width? : Double = 520.0,
  height? : Double = 340.0,
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
  let (ylo_raw, yhi_raw) = extent(ys)
  let (axis_lo, axis_hi, ticks) = nice_ticks(ylo_raw, yhi_raw, 5)
  let (xlo, xhi, x_ticks) = nice_ticks(xlo_raw, xhi_raw, 6)
  // Area-true scaling: radius grows with the square root of size.
  let mut size_max = 0.0
  for p in data {
    if p.2 > size_max {
      size_max = p.2
    }
  }
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  body.write_string(
    y_axis(theme, left, top, plot_w, plot_h, axis_lo, axis_hi, ticks),
  )
  body.write_string(x_axis(theme, left, top, plot_w, plot_h, xlo, xhi, x_ticks))
  for i in 0..<data.length() {
    let (x, y, size) = data[i]
    let px = scale_linear(x, xlo, xhi, left, left + plot_w)
    let py = scale_linear(y, axis_lo, axis_hi, top + plot_h, top)
    let r = if size_max <= 0.0 || size <= 0.0 {
      2.0
    } else {
      let rr = max_radius * (size / size_max).sqrt()
      if rr < 2.0 {
        2.0
      } else {
        rr
      }
    }
    let color = theme.color_at(i)
    body.write_string(
      elem("circle", [
        ("cx", num(px)),
        ("cy", num(py)),
        ("r", num(r)),
        ("fill", color),
        ("fill-opacity", "0.55"),
        ("stroke", color),
        ("stroke-width", "1.5"),
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
