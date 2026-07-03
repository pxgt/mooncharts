// Heatmap: a matrix of values rendered as colored cells.

///|
/// Render a heatmap as a standalone SVG document string. `rows` and `cols`
/// label the grid and `values[r][c]` is the cell value; cell colors
/// interpolate between `low_color` and `high_color` across the value range,
/// and each cell prints its value with a contrast-aware text color. `title`,
/// `width`, `height`, the two scale colors and `theme` are optional.
pub fn heatmap(
  rows : Array[String],
  cols : Array[String],
  values : Array[Array[Double]],
  title? : String = "",
  width? : Double = 480.0,
  height? : Double = 340.0,
  low_color? : String = "#e6f1fb",
  high_color? : String = "#185fa5",
  theme? : Theme = Theme::light(),
) -> String {
  let left = 84.0
  let right = 16.0
  let top = if title == "" { 16.0 } else { 40.0 }
  let bottom = 32.0
  let plot_w = width - left - right
  let plot_h = height - top - bottom
  let n_r = rows.length()
  let n_c = cols.length()
  // Value range across the whole matrix.
  let mut lo = 0.0
  let mut hi = 0.0
  let mut first = true
  for row in values {
    for v in row {
      if first {
        lo = v
        hi = v
        first = false
      }
      if v < lo {
        lo = v
      }
      if v > hi {
        hi = v
      }
    }
  }
  let span = if hi - lo <= 0.0 { 1.0 } else { hi - lo }
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  if n_r > 0 && n_c > 0 {
    let cw = plot_w / n_c.to_double()
    let ch = plot_h / n_r.to_double()
    for r in 0..<n_r {
      for c in 0..<n_c {
        let v = if r < values.length() && c < values[r].length() {
          values[r][c]
        } else {
          lo
        }
        let t = (v - lo) / span
        let x = left + cw * c.to_double()
        let y = top + ch * r.to_double()
        body.write_string(
          elem("rect", [
            ("x", num(x + 1.0)),
            ("y", num(y + 1.0)),
            ("width", num(cw - 2.0)),
            ("height", num(ch - 2.0)),
            ("fill", lerp_color(low_color, high_color, t)),
            ("rx", "3"),
          ]),
        )
        // Value label, switching to white on dark cells.
        let text_color = if t > 0.55 { "#ffffff" } else { "#333333" }
        body.write_string(
          label(x + cw / 2.0, y + ch / 2.0 + 4.0, num(v), fill=text_color),
        )
      }
      // Row label on the left.
      body.write_string(
        label(
          left - 8.0,
          top + ch * r.to_double() + ch / 2.0 + 4.0,
          rows[r],
          anchor="end",
          fill=theme.text,
        ),
      )
    }
    // Column labels along the bottom.
    for c in 0..<n_c {
      body.write_string(
        label(
          left + cw * c.to_double() + cw / 2.0,
          top + plot_h + 16.0,
          cols[c],
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
