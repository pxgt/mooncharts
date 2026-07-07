// Edge-condition tests: every chart must stay well-formed on empty, single,
// flat, negative and mismatched inputs — no crashes, no invalid SVG.

///|
fn valid_svg(svg : String) -> Bool {
  svg.has_prefix("<svg") && svg.has_suffix("</svg>")
}

///|
test "charts survive empty data" {
  inspect(valid_svg(@mooncharts.bar_chart([])), content="true")
  inspect(valid_svg(@mooncharts.bar_chart_horizontal([])), content="true")
  inspect(valid_svg(@mooncharts.line_chart([])), content="true")
  inspect(valid_svg(@mooncharts.area_chart([])), content="true")
  inspect(valid_svg(@mooncharts.scatter_chart([])), content="true")
  inspect(valid_svg(@mooncharts.pie_chart([])), content="true")
  inspect(valid_svg(@mooncharts.histogram([])), content="true")
  inspect(valid_svg(@mooncharts.box_plot([])), content="true")
  inspect(valid_svg(@mooncharts.heatmap([], [], [])), content="true")
  inspect(valid_svg(@mooncharts.radar_chart([], [])), content="true")
  inspect(valid_svg(@mooncharts.candlestick_chart([])), content="true")
  inspect(valid_svg(@mooncharts.waterfall_chart([])), content="true")
  inspect(valid_svg(@mooncharts.bubble_chart([])), content="true")
  inspect(valid_svg(@mooncharts.line_chart_multi([])), content="true")
  inspect(valid_svg(@mooncharts.bar_chart_grouped([], [])), content="true")
  inspect(valid_svg(@mooncharts.bar_chart_stacked([], [])), content="true")
  inspect(valid_svg(@mooncharts.area_chart_stacked([], [])), content="true")
}

///|
test "charts survive a single data point" {
  inspect(valid_svg(@mooncharts.bar_chart([("only", 5.0)])), content="true")
  inspect(valid_svg(@mooncharts.line_chart([(1.0, 5.0)])), content="true")
  inspect(valid_svg(@mooncharts.area_chart([(1.0, 5.0)])), content="true")
  inspect(valid_svg(@mooncharts.scatter_chart([(1.0, 5.0)])), content="true")
  inspect(valid_svg(@mooncharts.pie_chart([("all", 1.0)])), content="true")
  inspect(valid_svg(@mooncharts.histogram([3.0])), content="true")
  inspect(valid_svg(@mooncharts.box_plot([("one", [7.0])])), content="true")
  inspect(
    valid_svg(@mooncharts.candlestick_chart([("d1", 10.0, 12.0, 9.0, 11.0)])),
    content="true",
  )
  inspect(
    valid_svg(@mooncharts.waterfall_chart([("step", 4.0)])),
    content="true",
  )
  inspect(
    valid_svg(@mooncharts.bubble_chart([(1.0, 2.0, 3.0)])),
    content="true",
  )
}

///|
test "charts survive flat (all-equal) values" {
  // A degenerate value domain must not divide by zero anywhere.
  inspect(
    valid_svg(@mooncharts.bar_chart([("a", 5.0), ("b", 5.0)])),
    content="true",
  )
  inspect(
    valid_svg(@mooncharts.line_chart([(0.0, 5.0), (1.0, 5.0)])),
    content="true",
  )
  inspect(
    valid_svg(@mooncharts.scatter_chart([(2.0, 5.0), (2.0, 5.0)])),
    content="true",
  )
  inspect(valid_svg(@mooncharts.histogram([4.0, 4.0, 4.0])), content="true")
  inspect(
    valid_svg(@mooncharts.box_plot([("flat", [5.0, 5.0, 5.0])])),
    content="true",
  )
}

///|
test "charts survive negative and mixed-sign values" {
  inspect(
    valid_svg(@mooncharts.waterfall_chart([("loss", -30.0), ("loss2", -10.0)])),
    content="true",
  )
  inspect(
    valid_svg(@mooncharts.line_chart([(0.0, -5.0), (1.0, 5.0)])),
    content="true",
  )
  inspect(valid_svg(@mooncharts.bar_chart([("neg", -8.0)])), content="true")
}

///|
test "multi-series charts tolerate mismatched series lengths" {
  // The second series is shorter; missing values are treated as zero.
  let svg = @mooncharts.bar_chart_grouped(["a", "b", "c"], [
    ("full", [1.0, 2.0, 3.0]),
    ("short", [4.0]),
  ])
  inspect(valid_svg(svg), content="true")
  let stacked = @mooncharts.bar_chart_stacked(["a", "b"], [
    ("full", [1.0, 2.0]),
    ("short", []),
  ])
  inspect(valid_svg(stacked), content="true")
}

///|
test "pie ignores non-positive slices but keeps their legend rows" {
  let svg = @mooncharts.pie_chart([("ok", 5.0), ("zero", 0.0), ("neg", -3.0)])
  inspect(valid_svg(svg), content="true")
  inspect(svg.contains("zero"), content="true")
  inspect(svg.contains("neg"), content="true")
}

///|
test "bubble sizes of zero fall back to a minimum radius" {
  let svg = @mooncharts.bubble_chart([(1.0, 1.0, 0.0), (2.0, 2.0, 100.0)])
  inspect(valid_svg(svg), content="true")
  inspect(svg.contains("r=\"2\""), content="true")
}
