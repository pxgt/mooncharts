// Box-and-whisker plot built on the quartile helpers in stats.mbt.

///|
/// Render a box plot as a standalone SVG document string: one box per
/// `(label, samples)` pair. Boxes span the interquartile range with a median
/// line; whiskers extend to the furthest samples within 1.5×IQR of the box,
/// and samples beyond the whiskers are drawn as outlier dots. `title`,
/// `width`, `height` and `theme` are optional.
pub fn box_plot(
  data : Array[(String, Array[Double])],
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
  // Global value range across every sample of every series.
  let all : Array[Double] = []
  for d in data {
    for v in d.1 {
      all.push(v)
    }
  }
  let (raw_lo, raw_hi) = extent(all)
  let (axis_lo, axis_hi, ticks) = nice_ticks(raw_lo, raw_hi, 5)
  let n = data.length()
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  body.write_string(
    y_axis(theme, left, top, plot_w, plot_h, axis_lo, axis_hi, ticks),
  )
  if n > 0 {
    let slot = plot_w / n.to_double()
    let bw = slot * 0.45
    for i in 0..<n {
      let (name, samples) = data[i]
      let cx = left + slot * (i.to_double() + 0.5)
      // Category label regardless of sample count.
      body.write_string(label(cx, top + plot_h + 16.0, name, fill=theme.text))
      if samples.length() > 0 {
        let color = theme.color_at(i)
        let (q1, med, q3) = quartiles(samples)
        let iqr = q3 - q1
        let fence_lo = q1 - 1.5 * iqr
        let fence_hi = q3 + 1.5 * iqr
        // Whiskers reach the furthest samples inside the fences.
        let mut w_lo = q1
        let mut w_hi = q3
        for v in samples {
          if v >= fence_lo && v < w_lo {
            w_lo = v
          }
          if v <= fence_hi && v > w_hi {
            w_hi = v
          }
        }
        let sy = fn(v : Double) -> Double {
          scale_linear(v, axis_lo, axis_hi, top + plot_h, top)
        }
        // Whisker stem and end caps.
        body.write_string(
          elem("line", [
            ("x1", num(cx)),
            ("y1", num(sy(w_lo))),
            ("x2", num(cx)),
            ("y2", num(sy(w_hi))),
            ("stroke", color),
            ("stroke-width", "1.5"),
          ]),
        )
        for cap in [w_lo, w_hi] {
          body.write_string(
            elem("line", [
              ("x1", num(cx - bw * 0.3)),
              ("y1", num(sy(cap))),
              ("x2", num(cx + bw * 0.3)),
              ("y2", num(sy(cap))),
              ("stroke", color),
              ("stroke-width", "1.5"),
            ]),
          )
        }
        // The interquartile box with its median line.
        body.write_string(
          elem("rect", [
            ("x", num(cx - bw / 2.0)),
            ("y", num(sy(q3))),
            ("width", num(bw)),
            ("height", num(sy(q1) - sy(q3))),
            ("fill", color),
            ("fill-opacity", "0.25"),
            ("stroke", color),
            ("stroke-width", "1.5"),
            ("rx", "2"),
          ]),
        )
        body.write_string(
          elem("line", [
            ("x1", num(cx - bw / 2.0)),
            ("y1", num(sy(med))),
            ("x2", num(cx + bw / 2.0)),
            ("y2", num(sy(med))),
            ("stroke", color),
            ("stroke-width", "2.5"),
          ]),
        )
        // Outliers beyond the fences.
        for v in samples {
          if v < fence_lo || v > fence_hi {
            body.write_string(
              elem("circle", [
                ("cx", num(cx)),
                ("cy", num(sy(v))),
                ("r", "3"),
                ("fill", color),
                ("fill-opacity", "0.8"),
              ]),
            )
          }
        }
      }
    }
  }
  if title != "" {
    body.write_string(
      label(width / 2.0, 24.0, title, size=16, weight="bold", fill=theme.title),
    )
  }
  document(width, height, body.to_string())
}
