// Numeric scaling helpers shared by the XY charts (line, scatter).

///|
/// The minimum and maximum of a list of values. An empty list yields `(0, 1)`
/// so callers can scale and divide without special-casing emptiness.
fn extent(values : Array[Double]) -> (Double, Double) {
  if values.length() == 0 {
    return (0.0, 1.0)
  }
  let mut lo = values[0]
  let mut hi = values[0]
  for v in values {
    if v < lo {
      lo = v
    }
    if v > hi {
      hi = v
    }
  }
  (lo, hi)
}

///|
/// Linearly map `v` from the domain `[d0, d1]` onto the range `[r0, r1]`.
/// A degenerate domain (`d0 == d1`) maps to the midpoint of the range.
fn scale_linear(
  v : Double,
  d0 : Double,
  d1 : Double,
  r0 : Double,
  r1 : Double,
) -> Double {
  if d0 == d1 {
    (r0 + r1) / 2.0
  } else {
    r0 + (v - d0) / (d1 - d0) * (r1 - r0)
  }
}
