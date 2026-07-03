// Histogram: frequency distribution of raw samples.

///|
/// Count `values` into `bins` equal-width bins covering `[lo, hi]`. Samples
/// outside the range are ignored; the top edge closes into the last bin.
fn hist_counts(
  values : Array[Double],
  lo : Double,
  hi : Double,
  bins : Int,
) -> Array[Int] {
  let counts : Array[Int] = []
  for _i in 0..<bins {
    counts.push(0)
  }
  let span = hi - lo
  if span <= 0.0 {
    return counts
  }
  for v in values {
    if v >= lo && v <= hi {
      let mut idx = ((v - lo) / span * bins.to_double()).to_int()
      if idx >= bins {
        idx = bins - 1
      }
      counts[idx] = counts[idx] + 1
    }
  }
  counts
}

///|
/// Render a histogram of raw `values` as a standalone SVG document string:
/// samples are counted into `bins` equal-width bins over a nicely rounded
/// range and drawn as near-flush bars. `bins`, `title`, `width`, `height` and
/// `theme` are optional.
pub fn histogram(
  values : Array[Double],
  bins? : Int = 10,
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
  let bins = if bins < 1 { 1 } else { bins }
  // Round the sample range so bin edges land on friendly numbers.
  let (raw_lo, raw_hi) = extent(values)
  let (lo, hi, x_ticks) = nice_ticks(raw_lo, raw_hi, 6)
  let counts = hist_counts(values, lo, hi, bins)
  let mut max_c = 0
  for c in counts {
    if c > max_c {
      max_c = c
    }
  }
  let max_c = if max_c == 0 { 1 } else { max_c }
  let (axis_lo, axis_hi, ticks) = nice_ticks(0.0, max_c.to_double(), 5)
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  body.write_string(
    y_axis(theme, left, top, plot_w, plot_h, axis_lo, axis_hi, ticks),
  )
  body.write_string(x_axis(theme, left, top, plot_w, plot_h, lo, hi, x_ticks))
  let bw = plot_w / bins.to_double()
  for i in 0..<bins {
    if counts[i] > 0 {
      let h = counts[i].to_double() / axis_hi * plot_h
      body.write_string(
        elem("rect", [
          ("x", num(left + bw * i.to_double() + bw * 0.04)),
          ("y", num(top + plot_h - h)),
          ("width", num(bw * 0.92)),
          ("height", num(h)),
          ("fill", theme.color_at(0)),
        ]),
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
