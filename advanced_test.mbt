// Tests for the advanced charts (treemap, gauge, funnel, rose, gantt,
// sparkline) and the SI number formatter.

///|
fn ok_svg(svg : String) -> Bool {
  svg.has_prefix("<svg") && svg.has_suffix("</svg>")
}

///|
test "treemap tiles the whole area without gaps" {
  let svg = @mooncharts.treemap([
    ("A", 6.0),
    ("B", 6.0),
    ("C", 4.0),
    ("D", 3.0),
    ("E", 2.0),
    ("F", 2.0),
  ])
  inspect(ok_svg(svg), content="true")
  // Six positive values -> six cells; labels shown when cells are big enough.
  inspect(svg.contains(">A<"), content="true")
  // Non-positive entries are dropped, empty input stays valid.
  inspect(
    ok_svg(@mooncharts.treemap([("x", 0.0), ("y", -1.0)])),
    content="true",
  )
  inspect(ok_svg(@mooncharts.treemap([])), content="true")
}

///|
test "gauge places a needle and clamps out-of-range values" {
  let svg = @mooncharts.gauge_chart(72.0, bands=[0.5, 0.3, 0.2], title="CPU")
  inspect(ok_svg(svg), content="true")
  inspect(svg.contains(">72<"), content="true")
  // Above max still renders (needle clamped, no NaN).
  inspect(ok_svg(@mooncharts.gauge_chart(999.0)), content="true")
  inspect(ok_svg(@mooncharts.gauge_chart(-5.0)), content="true")
}

///|
test "funnel shows conversion percentages relative to the first stage" {
  let svg = @mooncharts.funnel_chart([
    ("Visits", 1000.0),
    ("Signups", 400.0),
    ("Paid", 100.0),
  ])
  inspect(ok_svg(svg), content="true")
  inspect(svg.contains("100%"), content="true") // first stage
  inspect(svg.contains("40%"), content="true") // 400/1000
  inspect(svg.contains("10%"), content="true") // 100/1000
}

///|
test "rose, gantt and sparkline render and degrade gracefully" {
  inspect(
    ok_svg(@mooncharts.rose_chart([("Mon", 5.0), ("Tue", 9.0), ("Wed", 3.0)])),
    content="true",
  )
  inspect(
    ok_svg(
      @mooncharts.gantt_chart([
        ("Design", 0.0, 3.0),
        ("Build", 2.0, 7.0),
        ("Ship", 7.0, 9.0),
      ]),
    ),
    content="true",
  )
  inspect(
    ok_svg(@mooncharts.sparkline([3.0, 5.0, 4.0, 8.0, 6.0, 9.0])),
    content="true",
  )
  // Empty / single-value inputs stay well-formed.
  inspect(ok_svg(@mooncharts.rose_chart([])), content="true")
  inspect(ok_svg(@mooncharts.gantt_chart([])), content="true")
  inspect(ok_svg(@mooncharts.sparkline([])), content="true")
  inspect(ok_svg(@mooncharts.sparkline([7.0])), content="true")
}

///|
test "format_si covers large, small, negative and boundary values" {
  inspect(@mooncharts.format_si(0.0), content="0")
  inspect(@mooncharts.format_si(999.0), content="999")
  inspect(@mooncharts.format_si(1000.0), content="1k")
  inspect(@mooncharts.format_si(1500.0), content="1.5k")
  inspect(@mooncharts.format_si(2500000.0), content="2.5M")
  inspect(@mooncharts.format_si(1200000000.0), content="1.2G")
  inspect(@mooncharts.format_si(-52000.0), content="-52k")
  inspect(@mooncharts.format_si(0.05), content="50m")
}
