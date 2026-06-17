// XY scatter plot.

///|
/// Render a scatter plot of `(x, y)` points as a standalone SVG document
/// string. The y value axis gets nicely rounded gridlines; the x domain is
/// padded slightly so points never sit on the frame. `title`, `width`,
/// `height` and the point `radius` are optional.
pub fn scatter_chart(
  data : Array[(Double, Double)],
  title? : String = "",
  width? : Double = 480.0,
  height? : Double = 320.0,
  radius? : Double = 4.0,
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
  let (ylo, yhi) = extent(ys)
  // Pad the x domain by 5% so extreme points keep clear of the frame.
  let xpad = (xhi - xlo) * 0.05
  let (axis_lo, axis_hi, ticks) = nice_ticks(ylo, yhi, 5)
  let body = StringBuilder::new()
  // Gridlines and y-axis labels behind the points.
  body.write_string(y_axis(left, top, plot_w, plot_h, axis_lo, axis_hi, ticks))
  for i in 0..<data.length() {
    let (x, y) = data[i]
    let px = scale_linear(x, xlo - xpad, xhi + xpad, left, left + plot_w)
    let py = scale_linear(y, axis_lo, axis_hi, top + plot_h, top)
    body.write_string(
      elem("circle", [
        ("cx", num(px)),
        ("cy", num(py)),
        ("r", num(radius)),
        ("fill", color_at(0)),
        ("fill-opacity", "0.7"),
      ]),
    )
  }
  if title != "" {
    body.write_string(
      label(width / 2.0, 24.0, title, size=16, weight="bold", fill="#222222"),
    )
  }
  document(width, height, body.to_string())
}
