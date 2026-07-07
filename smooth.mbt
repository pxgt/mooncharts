// Smooth-curve path building shared by the line and area charts.

///|
/// SVG path data for a smooth curve through `pts` (pixel coordinates), built
/// by converting Catmull-Rom segments to cubic Bézier curves. With fewer than
/// three points this degrades to a straight line.
fn smooth_path(pts : Array[(Double, Double)]) -> String {
  let n = pts.length()
  if n == 0 {
    return ""
  }
  let sb = StringBuilder::new()
  sb.write_string("M " + num(pts[0].0) + " " + num(pts[0].1))
  if n < 3 {
    for i in 1..<n {
      sb.write_string(" L " + num(pts[i].0) + " " + num(pts[i].1))
    }
    return sb.to_string()
  }
  // Catmull-Rom with the standard 1/6 tension, clamping the neighbor lookups
  // at both ends of the series.
  for i in 0..<(n - 1) {
    let p0 = pts[if i == 0 { 0 } else { i - 1 }]
    let p1 = pts[i]
    let p2 = pts[i + 1]
    let p3 = pts[if i + 2 >= n { n - 1 } else { i + 2 }]
    let c1x = p1.0 + (p2.0 - p0.0) / 6.0
    let c1y = p1.1 + (p2.1 - p0.1) / 6.0
    let c2x = p2.0 - (p3.0 - p1.0) / 6.0
    let c2y = p2.1 - (p3.1 - p1.1) / 6.0
    sb.write_string(
      " C " +
      num(c1x) +
      " " +
      num(c1y) +
      ", " +
      num(c2x) +
      " " +
      num(c2y) +
      ", " +
      num(p2.0) +
      " " +
      num(p2.1),
    )
  }
  sb.to_string()
}
