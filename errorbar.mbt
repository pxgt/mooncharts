// Error-bar rendering shared by the bar, line and scatter charts.

///|
/// A vertical error bar centered on `x` (pixel coordinates): a stem from
/// `y_lo` to `y_hi` with horizontal caps at both ends.
fn error_bar(
  x : Double,
  y_lo : Double,
  y_hi : Double,
  cap_w : Double,
  color : String,
) -> String {
  let sb = StringBuilder::new()
  sb.write_string(
    elem("line", [
      ("x1", num(x)),
      ("y1", num(y_lo)),
      ("x2", num(x)),
      ("y2", num(y_hi)),
      ("stroke", color),
      ("stroke-width", "1.5"),
    ]),
  )
  for y in [y_lo, y_hi] {
    sb.write_string(
      elem("line", [
        ("x1", num(x - cap_w / 2.0)),
        ("y1", num(y)),
        ("x2", num(x + cap_w / 2.0)),
        ("y2", num(y)),
        ("stroke", color),
        ("stroke-width", "1.5"),
      ]),
    )
  }
  sb.to_string()
}

///|
/// Symmetric error magnitude for point `i`, or 0 when no error was supplied.
fn error_at(errors : Array[Double], i : Int) -> Double {
  if i < errors.length() {
    let e = errors[i]
    if e < 0.0 {
      -e
    } else {
      e
    }
  } else {
    0.0
  }
}

///|
/// Extent of `values` widened so that every `value ± error` stays inside.
fn extent_with_errors(
  values : Array[Double],
  errors : Array[Double],
) -> (Double, Double) {
  let (lo0, hi0) = extent(values)
  let mut lo = lo0
  let mut hi = hi0
  for i in 0..<values.length() {
    let e = error_at(errors, i)
    if values[i] - e < lo {
      lo = values[i] - e
    }
    if values[i] + e > hi {
      hi = values[i] + e
    }
  }
  (lo, hi)
}
