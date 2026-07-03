# mooncharts API reference

All functions live in the `Xpeng/mooncharts` package (`moon add Xpeng/mooncharts`,
then import it and call via `@mooncharts.…`). Every chart function returns a
**complete, standalone SVG document string**.

Shared optional parameters (all charts): `title? : String`,
`width? : Double`, `height? : Double`, `theme? : Theme` (defaults to
`Theme::light()`).

## Charts

### Category charts — `Array[(String, Double)]`

| Function | Signature highlights | Notes |
|----------|---------------------|-------|
| `bar_chart(data)` | — | vertical bars; **negative values** grow down from the zero baseline |
| `bar_chart_horizontal(data)` | — | sideways bars, category labels on the left; non-negative values |
| `pie_chart(data, donut?)` | `donut? : Double = 0.0` | pie; pass `donut=0.4..0.7` for a donut ring |

### Multi-series category charts — `Array[String]` + `Array[(String, Array[Double])]`

`categories[i]` names the i-th group; each `(name, values)` series supplies
`values[i]` for that group. All include a legend.

| Function | Notes |
|----------|-------|
| `bar_chart_grouped(categories, series)` | bars side by side within each category |
| `bar_chart_stacked(categories, series)` | series stacked into one bar per category |
| `radar_chart(axes, series)` | spokes per axis, one translucent polygon per series |

### XY charts — `Array[(Double, Double)]`

Both axes get nicely rounded tick labels; the y axis draws gridlines and
anchors at zero when all values are positive.

| Function | Signature highlights | Notes |
|----------|---------------------|-------|
| `line_chart(points)` | — | polyline with point markers |
| `area_chart(points)` | — | line with translucent fill down to the baseline |
| `scatter_chart(points, radius?)` | `radius? : Double = 4.0` | dots only |
| `line_chart_multi(series)` | `Array[(String, Array[(Double, Double)])]` | several named lines + legend |
| `area_chart_stacked(xs, series)` | `Array[Double]` + `Array[(String, Array[Double])]` | layers accumulate upward + legend |

### Statistical charts

| Function | Signature highlights | Notes |
|----------|---------------------|-------|
| `histogram(values, bins?)` | `bins? : Int = 10` | raw samples binned over a nicely rounded range |
| `box_plot(data)` | `Array[(String, Array[Double])]` | quartile box, median line, 1.5×IQR whiskers, outlier dots |
| `heatmap(rows, cols, values, low_color?, high_color?)` | `values : Array[Array[Double]]` | cells colored by linear interpolation between the two scale colors |

## Theming

```
pub(all) struct Theme {
  palette    : Array[String] // series colors, cycled by index
  background : String        // "" = transparent
  grid       : String
  axis       : String
  text       : String
  title      : String
}
```

- `Theme::light()` — default; transparent background, dark text.
- `Theme::dark()` — dark background (`#1e1e2e`), brighter palette.
- `theme.with_palette(colors)` — copy of the theme with custom series colors.
- Because `Theme` is `pub(all)`, you can also construct one from scratch.

```mbt nocheck
let custom = @mooncharts.Theme::light().with_palette(["#ff5733", "#33c1ff"])
let svg = @mooncharts.bar_chart(data, theme=custom)
```

## Statistics helpers

Reusable on their own; `box_plot` builds on them.

| Function | Returns | Notes |
|----------|---------|-------|
| `mean(values)` | `Double` | arithmetic mean; `0` for empty input |
| `median(values)` | `Double` | `0` for empty input |
| `quartiles(values)` | `(Double, Double, Double)` | `(q1, median, q3)`, median-split method; single sample collapses onto itself |

## SVG primitives

Low-level building blocks — compose your own shapes with the same escaping and
number formatting the charts use.

| Function | Purpose |
|----------|---------|
| `escape(s)` | XML-escape text/attribute content |
| `num(x)` | compact coordinate formatting (≤2 decimals, no trailing zeros) |
| `elem(tag, attrs)` | self-closing element, e.g. `<rect … />` |
| `container(tag, attrs, inner)` | wrapping element, e.g. `<g>…</g>` |
| `text(x, y, content, attrs)` | `<text>` element with escaped content |
| `document(width, height, body)` | root `<svg>` with namespace + viewBox |

## JS interop

The `web/` package exports `render(kind, labels, values, dark)` to JavaScript
(`iife` format, attached to `globalThis`) — see the
[live demo](https://pxgt.github.io/mooncharts/) and `web/render.mbt` for the
pattern to expose your own entry points.
