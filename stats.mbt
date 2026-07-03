// Statistics helpers. Public so they can be reused on their own; the box plot
// builds on them.

///|
/// A sorted copy of `values` (the input is left untouched).
fn sorted_copy(values : Array[Double]) -> Array[Double] {
  let copy = values.copy()
  copy.sort()
  copy
}

///|
/// Median of the slice `sorted[lo..<hi]` of an ascending array; 0 when the
/// slice is empty.
fn median_sorted(sorted : Array[Double], lo : Int, hi : Int) -> Double {
  let n = hi - lo
  if n <= 0 {
    return 0.0
  }
  let mid = lo + n / 2
  if n % 2 == 1 {
    sorted[mid]
  } else {
    (sorted[mid - 1] + sorted[mid]) / 2.0
  }
}

///|
/// Arithmetic mean of `values`; 0 for an empty list.
///
/// # Example
/// ```mbt check
/// test {
///   inspect(@mooncharts.mean([1.0, 2.0, 3.0, 4.0]), content="2.5")
/// }
/// ```
pub fn mean(values : Array[Double]) -> Double {
  if values.length() == 0 {
    return 0.0
  }
  let mut sum = 0.0
  for v in values {
    sum += v
  }
  sum / values.length().to_double()
}

///|
/// Median of `values`; 0 for an empty list.
///
/// # Example
/// ```mbt check
/// test {
///   inspect(@mooncharts.median([3.0, 1.0, 2.0]), content="2")
///   inspect(@mooncharts.median([4.0, 1.0, 3.0, 2.0]), content="2.5")
/// }
/// ```
pub fn median(values : Array[Double]) -> Double {
  let s = sorted_copy(values)
  median_sorted(s, 0, s.length())
}

///|
/// `(q1, median, q3)` quartiles of `values` using the median-split (Tukey)
/// method: the lower/upper halves exclude the middle element when the count is
/// odd. Returns `(0, 0, 0)` for an empty list.
///
/// # Example
/// ```mbt check
/// test {
///   let (q1, m, q3) = @mooncharts.quartiles([
///     1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0,
///   ])
///   inspect(q1, content="2.5")
///   inspect(m, content="5")
///   inspect(q3, content="7.5")
/// }
/// ```
pub fn quartiles(values : Array[Double]) -> (Double, Double, Double) {
  let s = sorted_copy(values)
  let n = s.length()
  if n == 0 {
    return (0.0, 0.0, 0.0)
  }
  if n == 1 {
    // With a single sample every quartile collapses onto it.
    return (s[0], s[0], s[0])
  }
  let med = median_sorted(s, 0, n)
  let half = n / 2
  let upper_lo = if n % 2 == 1 { half + 1 } else { half }
  (median_sorted(s, 0, half), med, median_sorted(s, upper_lo, n))
}
