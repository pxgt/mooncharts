// Gantt chart: labeled tasks drawn as bars along a shared time axis.

///|
/// Render a Gantt chart as a standalone SVG document string. Each task is
/// `(name, start, end)` on an arbitrary numeric time scale (days, weeks, …);
/// bars share a rounded time axis with vertical gridlines. `title`, `width`,
/// `height` and `theme` are optional.
pub fn gantt_chart(
  tasks : Array[(String, Double, Double)],
  title? : String = "",
  width? : Double = 560.0,
  height? : Double = 320.0,
  theme? : Theme = Theme::light(),
) -> String {
  let left = 110.0
  let right = 16.0
  let top = if title == "" { 16.0 } else { 40.0 }
  let bottom = 36.0
  let plot_w = width - left - right
  let plot_h = height - top - bottom
  let n = tasks.length()
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  if n > 0 {
    // Time domain spans every task; round it for clean gridlines.
    let mut t_lo = tasks[0].1
    let mut t_hi = tasks[0].2
    for t in tasks {
      if t.1 < t_lo {
        t_lo = t.1
      }
      if t.2 > t_hi {
        t_hi = t.2
      }
    }
    let (axis_lo, axis_hi, ticks) = nice_ticks(t_lo, t_hi, 6)
    let tx = fn(v : Double) -> Double {
      scale_linear(v, axis_lo, axis_hi, left, left + plot_w)
    }
    // Vertical time gridlines + axis labels.
    for tk in ticks {
      let x = tx(tk)
      body.write_string(
        elem("line", [
          ("x1", num(x)),
          ("y1", num(top)),
          ("x2", num(x)),
          ("y2", num(top + plot_h)),
          ("stroke", theme.grid),
          ("stroke-width", "1"),
        ]),
      )
      body.write_string(label(x, top + plot_h + 16.0, num(tk), fill=theme.axis))
    }
    let row_h = plot_h / n.to_double()
    let bar_h = row_h * 0.6
    for i in 0..<n {
      let (name, start, end) = tasks[i]
      let y = top + row_h * i.to_double() + (row_h - bar_h) / 2.0
      let x0 = tx(start)
      let x1 = tx(end)
      let w = {
        let ww = x1 - x0
        if ww < 2.0 {
          2.0
        } else {
          ww
        }
      }
      body.write_string(
        elem("rect", [
          ("x", num(x0)),
          ("y", num(y)),
          ("width", num(w)),
          ("height", num(bar_h)),
          ("fill", theme.color_at(i)),
          ("rx", "3"),
        ]),
      )
      body.write_string(
        label(
          left - 10.0,
          y + bar_h / 2.0 + 4.0,
          name,
          anchor="end",
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
