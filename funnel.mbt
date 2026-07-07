// Funnel chart: successive stages drawn as centered trapezoids.

///|
/// Render a funnel chart as a standalone SVG document string. Each
/// `(label, value)` becomes a horizontal band whose width is proportional to
/// its value; consecutive bands are joined into trapezoids so the funnel
/// tapers from the largest stage down. A conversion percentage relative to the
/// first stage is printed on each band. `title`, `width`, `height` and `theme`
/// are optional.
pub fn funnel_chart(
  data : Array[(String, Double)],
  title? : String = "",
  width? : Double = 460.0,
  height? : Double = 340.0,
  theme? : Theme = Theme::light(),
) -> String {
  let left = 110.0
  let right = 16.0
  let top = if title == "" { 16.0 } else { 40.0 }
  let bottom = 16.0
  let plot_w = width - left - right
  let plot_h = height - top - bottom
  let cx = left + plot_w / 2.0
  let n = data.length()
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  if n > 0 {
    // The first stage is the widest reference.
    let mut vmax = 0.0
    for d in data {
      if d.1 > vmax {
        vmax = d.1
      }
    }
    if vmax <= 0.0 {
      vmax = 1.0
    }
    let first = if data[0].1 > 0.0 { data[0].1 } else { vmax }
    let band_h = plot_h / n.to_double()
    let half = fn(v : Double) -> Double { v / vmax * plot_w / 2.0 }
    for i in 0..<n {
      let (name, value) = data[i]
      let y = top + band_h * i.to_double()
      let next = if i + 1 < n { data[i + 1].1 } else { value }
      let ht = half(value)
      let hb = half(next)
      let color = theme.color_at(i)
      // Trapezoid: top edge width from this stage, bottom from the next.
      body.write_string(
        elem("polygon", [
          (
            "points",
            num(cx - ht) +
            "," +
            num(y) +
            " " +
            num(cx + ht) +
            "," +
            num(y) +
            " " +
            num(cx + hb) +
            "," +
            num(y + band_h) +
            " " +
            num(cx - hb) +
            "," +
            num(y + band_h),
          ),
          ("fill", color),
          ("fill-opacity", "0.85"),
        ]),
      )
      // Stage label to the left, value + conversion centered.
      body.write_string(
        label(
          left - 10.0,
          y + band_h / 2.0 + 4.0,
          name,
          anchor="end",
          fill=theme.text,
        ),
      )
      let pct = if first > 0.0 { (value / first * 100.0).to_int() } else { 0 }
      body.write_string(
        label(
          cx,
          y + band_h / 2.0 + 4.0,
          num(value) + "  (" + pct.to_string() + "%)",
          fill="#ffffff",
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
