# mooncharts cookbook

Copy-paste recipes for every chart. Each block is a runnable `moon test` case
(this file lives at the repo root and is checked by `moon test` in CI), so the snippets are guaranteed to compile
against the current release. Every call returns a complete SVG document string
you can write to a file or embed in a page.

Import once in your package's `moon.pkg`:

```
import { "Xpeng/mooncharts" }
```

## Bar charts

```mbt check
///|
test {
  // Vertical bars; negative values grow downward from the zero line.
  let svg = @mooncharts.bar_chart(
    [("Q1", 120.0), ("Q2", -30.0), ("Q3", 90.0)],
    title="Net change",
  )
  assert_true(svg.has_prefix("<svg"))
}
```

```mbt check
///|
test {
  // Horizontal bars read well for long category names.
  let svg = @mooncharts.bar_chart_horizontal([
    ("Engineering", 88.0),
    ("Design", 72.0),
    ("Marketing", 65.0),
  ])
  assert_true(svg.contains("Engineering"))
}
```

```mbt check
///|
test {
  // Error bars for measurements with uncertainty.
  let svg = @mooncharts.bar_chart([("A", 42.0), ("B", 55.0)], errors=[4.0, 6.0])
  assert_true(svg.has_prefix("<svg"))
}
```

## Grouped and stacked bars

```mbt check
///|
test {
  let cats = ["Q1", "Q2", "Q3", "Q4"]
  let series = [
    ("2024", [88.0, 122.0, 105.0, 153.0]),
    ("2025", [110.0, 140.0, 130.0, 175.0]),
  ]
  let grouped = @mooncharts.bar_chart_grouped(cats, series)
  let stacked = @mooncharts.bar_chart_stacked(cats, series)
  assert_true(grouped.has_prefix("<svg"))
  assert_true(stacked.has_prefix("<svg"))
}
```

## Lines and areas

```mbt check
///|
test {
  let pts : Array[(Double, Double)] = [
    (1.0, 12.0),
    (2.0, 19.0),
    (3.0, 15.0),
    (4.0, 25.0),
  ]
  // Straight, or a smooth Catmull-Rom curve, with axis titles.
  let sharp = @mooncharts.line_chart(pts)
  let smooth = @mooncharts.line_chart(
    pts,
    smooth=true,
    x_title="month",
    y_title="revenue",
  )
  assert_true(sharp.contains("<polyline"))
  assert_true(smooth.contains(" C "))
}
```

```mbt check
///|
test {
  // Filled area, and multiple stacked area layers sharing an x-axis.
  let area = @mooncharts.area_chart([(0.0, 3.0), (1.0, 5.0), (2.0, 4.0)])
  let stacked = @mooncharts.area_chart_stacked([1.0, 2.0, 3.0], [
    ("Mobile", [20.0, 26.0, 30.0]),
    ("Desktop", [35.0, 36.0, 34.0]),
  ])
  assert_true(area.has_prefix("<svg"))
  assert_true(stacked.contains("Mobile"))
}
```

## Multi-series line

```mbt check
///|
test {
  let svg = @mooncharts.line_chart_multi([
    ("Product A", [(1.0, 20.0), (2.0, 35.0), (3.0, 30.0)]),
    ("Product B", [(1.0, 12.0), (2.0, 18.0), (3.0, 28.0)]),
  ])
  assert_true(svg.contains("Product A"))
}
```

## Scatter and bubble

```mbt check
///|
test {
  let scatter = @mooncharts.scatter_chart([
    (2.0, 55.0),
    (3.0, 62.0),
    (4.0, 71.0),
  ])
  // Bubble adds a third value mapped to dot area.
  let bubble = @mooncharts.bubble_chart([(1.0, 30.0, 10.0), (2.0, 55.0, 45.0)])
  assert_true(scatter.has_prefix("<svg"))
  assert_true(bubble.has_prefix("<svg"))
}
```

## Pie, donut and rose

```mbt check
///|
test {
  let data = [
    ("Chrome", 65.0),
    ("Safari", 18.0),
    ("Edge", 10.0),
    ("Firefox", 7.0),
  ]
  let pie = @mooncharts.pie_chart(data)
  let donut = @mooncharts.pie_chart(data, donut=0.55)
  let rose = @mooncharts.rose_chart(data)
  assert_true(pie.has_prefix("<svg"))
  assert_true(donut.has_prefix("<svg"))
  assert_true(rose.has_prefix("<svg"))
}
```

## Statistical charts

```mbt check
///|
test {
  // Histogram bins raw samples; box plot summarizes distributions.
  let hist = @mooncharts.histogram([4.2, 5.1, 5.5, 6.0, 6.3, 7.1, 8.3], bins=5)
  let box = @mooncharts.box_plot([
    ("API", [42.0, 48.0, 52.0, 58.0, 95.0]),
    ("Web", [55.0, 62.0, 68.0, 75.0]),
  ])
  assert_true(hist.has_prefix("<svg"))
  assert_true(box.has_prefix("<svg"))
  // The helpers are usable on their own.
  assert_eq(@mooncharts.median([3.0, 1.0, 2.0]), 2.0)
}
```

## Radar

```mbt check
///|
test {
  let svg = @mooncharts.radar_chart(
    ["Speed", "Power", "Range", "Defense", "Magic"],
    [
      ("Warrior", [9.0, 8.0, 4.0, 9.0, 2.0]),
      ("Mage", [4.0, 6.0, 9.0, 3.0, 10.0]),
    ],
  )
  assert_true(svg.contains("Speed"))
}
```

## Heatmap

```mbt check
///|
test {
  let svg = @mooncharts.heatmap(["Mon", "Wed", "Fri"], ["9am", "12pm", "3pm"], [
    [12.0, 45.0, 38.0],
    [25.0, 62.0, 54.0],
    [18.0, 48.0, 70.0],
  ])
  assert_true(svg.has_prefix("<svg"))
}
```

## Financial and project charts

```mbt check
///|
test {
  // OHLC candlesticks.
  let candles = @mooncharts.candlestick_chart([
    ("Mon", 102.0, 108.0, 99.0, 106.0),
    ("Tue", 106.0, 112.0, 104.0, 110.0),
  ])
  // Waterfall for cumulative gains and losses.
  let bridge = @mooncharts.waterfall_chart([
    ("Revenue", 120.0),
    ("Costs", -45.0),
    ("Tax", -14.0),
  ])
  // Gantt for schedules.
  let plan = @mooncharts.gantt_chart([
    ("Design", 0.0, 3.0),
    ("Build", 2.0, 7.0),
    ("Ship", 7.0, 9.0),
  ])
  assert_true(candles.has_prefix("<svg"))
  assert_true(bridge.contains("Total"))
  assert_true(plan.contains("Design"))
}
```

## Treemap, funnel, gauge and sparkline

```mbt check
///|
test {
  let tree = @mooncharts.treemap([
    ("A", 40.0),
    ("B", 25.0),
    ("C", 20.0),
    ("D", 15.0),
  ])
  let funnel = @mooncharts.funnel_chart([
    ("Visits", 1000.0),
    ("Signups", 400.0),
    ("Paid", 100.0),
  ])
  let gauge = @mooncharts.gauge_chart(72.0, bands=[0.5, 0.3, 0.2])
  let spark = @mooncharts.sparkline([3.0, 5.0, 4.0, 8.0, 6.0, 9.0])
  assert_true(tree.has_prefix("<svg"))
  assert_true(funnel.contains("40%"))
  assert_true(gauge.contains("72"))
  assert_true(spark.has_prefix("<svg"))
}
```

## Theming and formatting

```mbt check
///|
test {
  // Dark theme and a custom palette.
  let dark = @mooncharts.bar_chart(
    [("A", 1.0)],
    theme=@mooncharts.Theme::dark(),
  )
  let custom = @mooncharts.Theme::light().with_palette(["#ff5733", "#33c1ff"])
  let themed = @mooncharts.bar_chart([("A", 1.0), ("B", 2.0)], theme=custom)
  assert_true(dark.contains("#1e1e2e"))
  assert_true(themed.contains("#ff5733"))
  // Compact SI number formatting for labels.
  assert_eq(@mooncharts.format_si(1500.0), "1.5k")
  assert_eq(@mooncharts.format_si(3400000.0), "3.4M")
}
```

