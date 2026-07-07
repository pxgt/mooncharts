// Candlestick (OHLC) chart.

///|
/// Render a candlestick chart as a standalone SVG document string. Each entry
/// of `data` is `(label, open, high, low, close)`; the thin wick spans
/// low..high and the body spans open..close. Rising candles (close >= open)
/// use `up_color`, falling ones `down_color`. `title`, `width`, `height` and
/// `theme` are optional.
pub fn candlestick_chart(
  data : Array[(String, Double, Double, Double, Double)],
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
  let bottom = 40.0
  let plot_w = width - left - right
  let plot_h = height - top - bottom
  // The value domain spans every wick.
  let lows = data.map(fn(d) { d.3 })
  let highs = data.map(fn(d) { d.2 })
  let (lo_raw, _) = extent(lows)
  let (_, hi_raw) = extent(highs)
  let (axis_lo, axis_hi, ticks) = nice_ticks(lo_raw, hi_raw, 5)
  let n = data.length()
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  body.write_string(
    y_axis(theme, left, top, plot_w, plot_h, axis_lo, axis_hi, ticks),
  )
  if n > 0 {
    let slot = plot_w / n.to_double()
    let body_w = slot * 0.55
    let sy = fn(v : Double) -> Double {
      scale_linear(v, axis_lo, axis_hi, top + plot_h, top)
    }
    for i in 0..<n {
      let (name, open, high, low, close) = data[i]
      let cx = left + slot * (i.to_double() + 0.5)
      let color = if close >= open { up_color } else { down_color }
      // Wick from low to high.
      body.write_string(
        elem("line", [
          ("x1", num(cx)),
          ("y1", num(sy(low))),
          ("x2", num(cx)),
          ("y2", num(sy(high))),
          ("stroke", color),
          ("stroke-width", "1.5"),
        ]),
      )
      // Body between open and close; keep at least 1px so dojis stay visible.
      let top_v = if open > close { open } else { close }
      let bot_v = if open > close { close } else { open }
      let y = sy(top_v)
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
          ("x", num(cx - body_w / 2.0)),
          ("y", num(y)),
          ("width", num(body_w)),
          ("height", num(h)),
          ("fill", color),
          ("rx", "1"),
        ]),
      )
      // Category label below the plot area.
      body.write_string(label(cx, top + plot_h + 16.0, name, fill=theme.text))
    }
  }
  if title != "" {
    body.write_string(
      label(width / 2.0, 24.0, title, size=16, weight="bold", fill=theme.title),
    )
  }
  document(width, height, body.to_string())
}
