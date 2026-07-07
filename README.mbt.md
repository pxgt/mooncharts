# mooncharts

[![CI](https://github.com/pxgt/mooncharts/actions/workflows/ci.yml/badge.svg)](https://github.com/pxgt/mooncharts/actions/workflows/ci.yml)

Lightweight, dependency-free **SVG charting for [MoonBit](https://www.moonbitlang.com/)**.
Turn typed data into standalone SVG documents you can drop into a web page, a
report, or a file — bar, line, area, pie/donut and scatter charts, plus
multi-series line and grouped bar charts, out of the box.

Because MoonBit compiles to JS, Wasm and native, the same chart code can run in
the browser or generate static SVG on the backend.

<p>
  <img src="examples/img-bar.svg" width="320" alt="bar chart" />
  <img src="examples/img-area.svg" width="320" alt="area chart" />
  <img src="examples/img-donut.svg" width="260" alt="donut chart with dark theme" />
</p>

> These images are real SVG output from the library. See `examples/interactive.html`
> for a live, in-browser demo.

## Features

- Twenty-four chart types: bar (vertical / horizontal / grouped / stacked),
  line, multi-series line, area, stacked area, pie, donut, rose, scatter,
  bubble, radar, histogram, box plot, heatmap, candlestick, waterfall,
  treemap, funnel, gauge, gantt, sparkline
- Nicely rounded ticks on both axes, gridlines, zero-baseline handling for
  negative values (Heckbert "nice numbers")
- Symmetric ±error bars on bar, line and scatter charts (`errors?`)
- Smooth Catmull-Rom curves on line and area charts (`smooth=true`)
- Axis titles on the XY charts (`x_title?` / `y_title?`)
- Reusable statistics helpers: `mean`, `median`, `quartiles`; SI number
  formatting (`format_si`: `1.2k`, `3.4M`)
- Squarified treemap layout, area-true rose/bubble sizing — real algorithms,
  unit-tested
- Micro-benchmarked: a typical chart renders in 12–25 µs (see Performance)
- Edge-condition tested: empty, single-point, flat and mixed-sign inputs
- A [runnable cookbook](cookbook.mbt.md) — every recipe is a `moon test` case
- Light / dark themes and custom color palettes
- Reusable SVG primitives — compose your own shapes
- Typed, defaulted configuration (no stringly-typed option bags)
- Zero dependencies beyond `moonbitlang/core`
- Snapshot-tested, with a runnable browser gallery

## Install

```bash
moon add Xpeng/mooncharts
```

Then import it in your package's `moon.pkg`:

```
import {
  "Xpeng/mooncharts",
}
```

## Quick start

```mbt check
///|
test {
  let svg = @mooncharts.bar_chart(
    [("Q1", 12.0), ("Q2", 19.0), ("Q3", 8.0), ("Q4", 15.0)],
    title="Quarterly Revenue",
  )
  // `svg` is a complete, standalone SVG document string.
  inspect(svg.has_prefix("<svg"), content="true")
  inspect(svg.contains("Quarterly Revenue"), content="true")
}
```

Write the returned string to a `.svg` file, or embed it directly in an HTML page.

## Chart types

| Function | Data shape | Notes |
|----------|------------|-------|
| `bar_chart` | `Array[(String, Double)]` | vertical bars with value + category labels |
| `line_chart` | `Array[(Double, Double)]` | XY line with point markers |
| `area_chart` | `Array[(Double, Double)]` | line with the region beneath it filled |
| `pie_chart` | `Array[(String, Double)]` | pie, or donut via `donut=0.0..1.0` |
| `scatter_chart` | `Array[(Double, Double)]` | XY scatter, configurable point `radius` |
| `line_chart_multi` | `Array[(String, Array[(Double, Double)])]` | several named line series + legend |
| `bar_chart_grouped` | `Array[String]`, `Array[(String, Array[Double])]` | grouped bars per category + legend |
| `bar_chart_stacked` | `Array[String]`, `Array[(String, Array[Double])]` | stacked bars per category + legend |
| `bar_chart_horizontal` | `Array[(String, Double)]` | sideways bars with left-hand category labels |
| `radar_chart` | `Array[String]`, `Array[(String, Array[Double])]` | spider chart, one filled polygon per series |
| `histogram` | `Array[Double]` | raw samples binned into `bins?` equal-width bars |
| `box_plot` | `Array[(String, Array[Double])]` | quartile boxes, 1.5×IQR whiskers, outlier dots |
| `area_chart_stacked` | `Array[Double]`, `Array[(String, Array[Double])]` | accumulated area layers + legend |
| `heatmap` | `Array[String]`, `Array[String]`, `Array[Array[Double]]` | color-scaled matrix cells with value labels |
| `candlestick_chart` | `Array[(String, Double, Double, Double, Double)]` | OHLC candles, rising/falling colors |
| `waterfall_chart` | `Array[(String, Double)]` | signed deltas accumulate, connectors + total bar |
| `bubble_chart` | `Array[(Double, Double, Double)]` | XY dots with area-true size scaling |

`bar_chart`, `line_chart` and `scatter_chart` also accept `errors? : Array[Double]`
to draw symmetric ±error bars (the value axis widens to fit them).

Full signatures for every function live in [`docs/api.md`](docs/api.md), and
runnable recipes for every chart in [`cookbook.mbt.md`](cookbook.mbt.md).

## Performance

Rendering is a pure string computation — no DOM, no canvas — so it is fast.
Measured with `moon bench`, MoonBit's built-in benchmark runner, on this
library's own calls:

| Benchmark | wasm-gc | js |
|-----------|--------:|---:|
| `pie_chart`, 6 slices | 17.7 µs | 11.9 µs |
| `bar_chart`, 6 bars | 24.3 µs | 15.8 µs |
| `line_chart`, 100 points | 94.9 µs | 62.3 µs |
| `heatmap`, 10×10 | 211 µs | 138 µs |
| `line_chart`, 1000 points | 1.12 ms | 0.55 ms |

Mean over `moon bench`'s repeated runs on one developer machine — reproduce
with `moon bench` / `moon bench --target js`. The
[live demo](https://pxgt.github.io/mooncharts/) also displays the render time
of every chart you build.

All chart functions share optional `title?`, `width?`, `height?` and `theme?` parameters.

## Theming

Every chart accepts an optional `theme?`. Use the built-in light (default) or
dark theme, or swap the series palette:

```mbt check
///|
test {
  let dark = @mooncharts.bar_chart(
    [("Q1", 12.0), ("Q2", 19.0)],
    theme=@mooncharts.Theme::dark(),
  )
  inspect(dark.contains("#1e1e2e"), content="true") // dark background

  let custom = @mooncharts.Theme::light().with_palette(["#ff5733", "#33c1ff"])
  let svg = @mooncharts.bar_chart([("A", 1.0), ("B", 2.0)], theme=custom)
  inspect(svg.contains("#ff5733"), content="true")
}
```

## Gallery

Run the bundled example to generate an HTML page showing every chart type:

```bash
moon run cmd/main > gallery.html
# then open gallery.html in your browser
```

## Live interactive demo

**▶ Try it live: <https://pxgt.github.io/mooncharts/>**

`examples/interactive.html` runs mooncharts **in the browser**: the library is
compiled to JavaScript and re-renders charts live as you switch chart types,
drag data sliders, or toggle the dark theme. The `web/` package exposes a
`render` function to JS via `link.js.exports`; rebuild the bundle with:

```bash
moon build --target js --release
cp _build/js/release/build/web/web.js examples/mooncharts.js
```

Then open `examples/interactive.html` in a browser.

## Project write-up

[`docs/devlog.md`](docs/devlog.md) is a development log covering the architecture,
the design decisions (SVG primitives, nice-number ticks, theming, multi-series),
what MoonBit was like to use, and the AI-assisted workflow behind the project.

## License

[Apache-2.0](LICENSE).
