// Waterfall chart: signed deltas accumulate left to right.

///|
/// Render a waterfall chart as a standalone SVG document string. Each
/// `(label, delta)` bar floats at the running total, colored `up_color` for
/// gains and `down_color` for losses, with dashed connectors between steps.
/// With `show_total` a final bar for the cumulative result is appended under
/// `total_label`. `title`, `width`, `height` and `theme` are optional.
pub fn waterfall_chart(
  data : Array[(String, Double)],
  show_total? : Bool = true,
  total_label? : String = "Total",
  up_color? : String = "#59a14f",
  down_color? : String = "#e15759",
  title? : String = "",
  width? : Double = 520.0,
  height? : Double = 340.0,
  theme? : Theme = Theme::light(),
) -> String {
  let left = 48.0
  let right = 16.0
  let top = if title == "" { 16.0 } else { 40.0 }
  let bottom = 48.0
  let plot_w = width - left - right
  let plot_h = height - top - bottom
  // Walk the running total once to find the value domain (zero included).
  let mut running = 0.0
  let mut lo = 0.0
  let mut hi = 0.0
  for d in data {
    running += d.1
    if running < lo {
      lo = running
    }
    if running > hi {
      hi = running
    }
  }
  let total = running
  let hi = if lo == 0.0 && hi == 0.0 { 1.0 } else { hi }
  let (axis_lo, axis_hi, ticks) = nice_ticks(lo, hi, 5)
  let n = data.length()
  let slots = if show_total { n + 1 } else { n }
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  body.write_string(
    y_axis(theme, left, top, plot_w, plot_h, axis_lo, axis_hi, ticks),
  )
  if n > 0 {
    let slot = plot_w / slots.to_double()
    let bar_w = slot * 0.6
    let sy = fn(v : Double) -> Double {
      scale_linear(v, axis_lo, axis_hi, top + plot_h, top)
    }
    let mut acc = 0.0
    for i in 0..<n {
      let (name, delta) = data[i]
      let start = acc
      let end = acc + delta
      let x = left + slot * i.to_double() + (slot - bar_w) / 2.0
      let color = if delta >= 0.0 { up_color } else { down_color }
      let top_v = if start > end { start } else { end }
      let bot_v = if start > end { end } else { start }
      let h = {
        let hh = sy(bot_v) - sy(top_v)
        if hh < 1.0 {
          1.0
        } else {
          hh
        }
      }
      body.write_string(
        elem("rect", [
          ("x", num(x)),
          ("y", num(sy(top_v))),
          ("width", num(bar_w)),
          ("height", num(h)),
          ("fill", color),
          ("rx", "1"),
        ]),
      )
      // Dashed connector from this bar's end to the next bar's start.
      if i < n - 1 || show_total {
        body.write_string(
          elem("line", [
            ("x1", num(x + bar_w)),
            ("y1", num(sy(end))),
            ("x2", num(x + slot)),
            ("y2", num(sy(end))),
            ("stroke", theme.axis),
            ("stroke-width", "1"),
            ("stroke-dasharray", "3 3"),
          ]),
        )
      }
      body.write_string(
        label(x + bar_w / 2.0, top + plot_h + 16.0, name, fill=theme.text),
      )
      acc = end
    }
    // The cumulative total as a final anchored bar.
    if show_total {
      let x = left + slot * n.to_double() + (slot - bar_w) / 2.0
      let top_v = if total > 0.0 { total } else { 0.0 }
      let bot_v = if total > 0.0 { 0.0 } else { total }
      let h = {
        let hh = sy(bot_v) - sy(top_v)
        if hh < 1.0 {
          1.0
        } else {
          hh
        }
      }
      body.write_string(
        elem("rect", [
          ("x", num(x)),
          ("y", num(sy(top_v))),
          ("width", num(bar_w)),
          ("height", num(h)),
          ("fill", theme.color_at(0)),
          ("rx", "1"),
        ]),
      )
      body.write_string(
        label(
          x + bar_w / 2.0,
          top + plot_h + 16.0,
          total_label,
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
