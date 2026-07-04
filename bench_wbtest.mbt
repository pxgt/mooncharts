// Render-time benchmarks. Run with `moon bench` (add `--target js` or
// `--target native` to compare backends).

///|
fn sine_points(n : Int) -> Array[(Double, Double)] {
  let pts : Array[(Double, Double)] = []
  for i in 0..<n {
    let x = i.to_double()
    pts.push((x, 100.0 + 80.0 * @math.sin(x / 7.0)))
  }
  pts
}

///|
test "bench bar_chart (6 bars)" (b : @bench.T) {
  let data = [
    ("Mon", 120.0),
    ("Tue", 200.0),
    ("Wed", 150.0),
    ("Thu", 80.0),
    ("Fri", 240.0),
    ("Sat", 60.0),
  ]
  b.bench(fn() { b.keep(bar_chart(data)) })
}

///|
test "bench line_chart (100 points)" (b : @bench.T) {
  let pts = sine_points(100)
  b.bench(fn() { b.keep(line_chart(pts)) })
}

///|
test "bench line_chart (1000 points)" (b : @bench.T) {
  let pts = sine_points(1000)
  b.bench(fn() { b.keep(line_chart(pts)) })
}

///|
test "bench pie_chart (6 slices)" (b : @bench.T) {
  let data = [
    ("A", 30.0),
    ("B", 25.0),
    ("C", 20.0),
    ("D", 12.0),
    ("E", 8.0),
    ("F", 5.0),
  ]
  b.bench(fn() { b.keep(pie_chart(data)) })
}

///|
test "bench heatmap (10x10)" (b : @bench.T) {
  let labels : Array[String] = []
  for i in 0..<10 {
    labels.push("L\{i}")
  }
  let values : Array[Array[Double]] = []
  for r in 0..<10 {
    let row : Array[Double] = []
    for c in 0..<10 {
      row.push(((r * 7 + c * 13) % 100).to_double())
    }
    values.push(row)
  }
  b.bench(fn() { b.keep(heatmap(labels, labels, values)) })
}
