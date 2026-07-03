// Value-axis rendering shared by the bar, line, area and scatter charts:
// horizontal gridlines plus right-aligned y-axis tick labels, and x-axis tick
// labels (optionally with vertical gridlines).

///|
/// Render horizontal gridlines and y-axis tick labels for a plot area whose
/// value domain is `[axis_lo, axis_hi]` with the given `ticks`. The zero line
/// (or the bottom of the domain when zero is out of range) is drawn in the
/// theme's stronger axis color.
fn y_axis(
  theme : Theme,
  left : Double,
  top : Double,
  plot_w : Double,
  plot_h : Double,
  axis_lo : Double,
  axis_hi : Double,
  ticks : Array[Double],
) -> String {
  let body = StringBuilder::new()
  let zero_in_range = axis_lo <= 0.0 && axis_hi >= 0.0
  for t in ticks {
    let y = scale_linear(t, axis_lo, axis_hi, top + plot_h, top)
    let is_base = if zero_in_range { t == 0.0 } else { t == axis_lo }
    let stroke = if is_base { theme.axis } else { theme.grid }
    body.write_string(
      elem("line", [
        ("x1", num(left)),
        ("y1", num(y)),
        ("x2", num(left + plot_w)),
        ("y2", num(y)),
        ("stroke", stroke),
        ("stroke-width", "1"),
      ]),
    )
    body.write_string(
      label(left - 6.0, y + 4.0, num(t), anchor="end", fill=theme.axis),
    )
  }
  body.to_string()
}

///|
/// Render x-axis tick labels below the plot area for a horizontal domain
/// `[axis_lo, axis_hi]`. With `grid=true`, vertical gridlines are drawn too
/// (used by the horizontal bar chart).
fn x_axis(
  theme : Theme,
  left : Double,
  top : Double,
  plot_w : Double,
  plot_h : Double,
  axis_lo : Double,
  axis_hi : Double,
  ticks : Array[Double],
  grid? : Bool = false,
) -> String {
  let body = StringBuilder::new()
  for t in ticks {
    let x = scale_linear(t, axis_lo, axis_hi, left, left + plot_w)
    if grid {
      let stroke = if t == axis_lo { theme.axis } else { theme.grid }
      body.write_string(
        elem("line", [
          ("x1", num(x)),
          ("y1", num(top)),
          ("x2", num(x)),
          ("y2", num(top + plot_h)),
          ("stroke", stroke),
          ("stroke-width", "1"),
        ]),
      )
    }
    body.write_string(label(x, top + plot_h + 16.0, num(t), fill=theme.axis))
  }
  body.to_string()
}
