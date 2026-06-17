// Value-axis rendering shared by the bar, line and scatter charts: horizontal
// gridlines plus right-aligned y-axis tick labels.

///|
/// Render horizontal gridlines and y-axis tick labels for a plot area whose
/// value domain is `[axis_lo, axis_hi]` with the given `ticks`. The baseline
/// (the tick at the bottom of the domain) is drawn slightly darker.
fn y_axis(
  left : Double,
  top : Double,
  plot_w : Double,
  plot_h : Double,
  axis_lo : Double,
  axis_hi : Double,
  ticks : Array[Double],
) -> String {
  let body = StringBuilder::new()
  for t in ticks {
    let y = scale_linear(t, axis_lo, axis_hi, top + plot_h, top)
    let stroke = if t == axis_lo { "#bbbbbb" } else { "#eeeeee" }
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
      label(left - 6.0, y + 4.0, num(t), anchor="end", fill="#888888"),
    )
  }
  body.to_string()
}
