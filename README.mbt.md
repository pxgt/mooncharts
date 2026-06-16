# mooncharts

Lightweight, dependency-free **SVG charting for [MoonBit](https://www.moonbitlang.com/)**.
Turn typed data into standalone SVG documents you can drop into a web page, a
report, or a file — bar, line, pie/donut and scatter charts out of the box.

Because MoonBit compiles to JS, Wasm and native, the same chart code can run in
the browser or generate static SVG on the backend.

## Features

- Five chart types: bar, line, pie, donut, scatter
- Reusable SVG primitives — compose your own shapes
- Built-in color palette, titles, legends, configurable size
- Typed, defaulted configuration (no stringly-typed option bags)
- Zero dependencies beyond `moonbitlang/core`
- Snapshot-tested, with a runnable browser gallery

## Install

```bash
moon add pxgt/mooncharts
```

Then import it in your package's `moon.pkg`:

```
import {
  "pxgt/mooncharts",
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
| `pie_chart` | `Array[(String, Double)]` | pie, or donut via `donut=0.0..1.0` |
| `scatter_chart` | `Array[(Double, Double)]` | XY scatter, configurable point `radius` |

All chart functions share optional `title?`, `width?` and `height?` parameters.

## Gallery

Run the bundled example to generate an HTML page showing every chart type:

```bash
moon run cmd/main > gallery.html
# then open gallery.html in your browser
```

## License

[Apache-2.0](LICENSE).
