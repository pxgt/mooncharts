// "Nice numbers" axis-tick generation (Heckbert's algorithm). Produces evenly
// spaced, human-friendly tick values for a value axis so charts get readable
// gridlines like 0, 50, 100, ... instead of raw data extremes.

///|
/// Return a "nice" number approximately equal to `x` (which must be positive).
/// When `round` is true it rounds to the nearest nice number {1, 2, 5, 10}·10^k;
/// otherwise it rounds up to one.
fn nice_num(x : Double, round : Bool) -> Double {
  let exp = @math.floor(@math.log10(x))
  let frac = x / @math.pow(10.0, exp)
  let nice = if round {
    if frac < 1.5 {
      1.0
    } else if frac < 3.0 {
      2.0
    } else if frac < 7.0 {
      5.0
    } else {
      10.0
    }
  } else if frac <= 1.0 {
    1.0
  } else if frac <= 2.0 {
    2.0
  } else if frac <= 5.0 {
    5.0
  } else {
    10.0
  }
  nice * @math.pow(10.0, exp)
}

///|
/// Compute about `target` evenly spaced, nicely rounded ticks covering
/// `[lo, hi]`. Returns the (possibly expanded) axis bounds together with the
/// tick values, e.g. `nice_ticks(0, 240, 5)` -> bounds `0..250`, ticks
/// `[0, 50, 100, 150, 200, 250]`.
fn nice_ticks(
  lo : Double,
  hi : Double,
  target : Int,
) -> (Double, Double, Array[Double]) {
  // Guard a degenerate range so we still produce a sensible axis.
  let hi = if hi <= lo { lo + 1.0 } else { hi }
  let count = if target < 2 { 2 } else { target }
  let span = nice_num(hi - lo, false)
  let step = nice_num(span / (count - 1).to_double(), true)
  let axis_lo = @math.floor(lo / step) * step
  let axis_hi = @math.ceil(hi / step) * step
  // Derive the tick count from an index to avoid float drift in the values.
  let n = ((axis_hi - axis_lo) / step).to_int() + 1
  let ticks : Array[Double] = []
  for i in 0..<n {
    ticks.push(axis_lo + i.to_double() * step)
  }
  (axis_lo, axis_hi, ticks)
}
