// Blackbox tests run against the package's public API. Use `@mooncharts` to import.
// Prefer high-level behaviors over implementation details.
// Run `moon test` to execute and `moon test --update` to refresh snapshots.

///|
test "escape replaces XML special characters" {
  inspect(
    @mooncharts.escape("a<b>&\"c'd"),
    content="a&lt;b&gt;&amp;&quot;c&#39;d",
  )
}

///|
test "num drops trailing .0 but keeps real decimals" {
  inspect(@mooncharts.num(10.0), content="10")
  inspect(@mooncharts.num(10.5), content="10.5")
  inspect(@mooncharts.num(-3.0), content="-3")
}

///|
test "elem renders a self-closing element" {
  inspect(
    @mooncharts.elem("rect", [("x", "0"), ("width", "10")]),
    content=(
      #|<rect x="0" width="10" />
    ),
  )
}

///|
test "document wraps body with svg namespace and viewBox" {
  inspect(
    @mooncharts.document(100.0, 50.0, ""),
    content=(
      #|<svg xmlns="http://www.w3.org/2000/svg" width="100" height="50" viewBox="0 0 100 50"></svg>
    ),
  )
}

///|
test "bar_chart renders one bar with baseline and labels" {
  inspect(
    @mooncharts.bar_chart([("A", 10.0)], width=120.0, height=90.0),
    content=(
      #|<svg xmlns="http://www.w3.org/2000/svg" width="120" height="90" viewBox="0 0 120 90"><line x1="48" y1="42" x2="104" y2="42" stroke="#999999" stroke-width="1" /><text x="42" y="46" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">0</text><line x1="48" y1="36.8" x2="104" y2="36.8" stroke="#e6e6e6" stroke-width="1" /><text x="42" y="40.8" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">2</text><line x1="48" y1="31.6" x2="104" y2="31.6" stroke="#e6e6e6" stroke-width="1" /><text x="42" y="35.6" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">4</text><line x1="48" y1="26.4" x2="104" y2="26.4" stroke="#e6e6e6" stroke-width="1" /><text x="42" y="30.4" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">6</text><line x1="48" y1="21.2" x2="104" y2="21.2" stroke="#e6e6e6" stroke-width="1" /><text x="42" y="25.2" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">8</text><line x1="48" y1="16" x2="104" y2="16" stroke="#e6e6e6" stroke-width="1" /><text x="42" y="20" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">10</text><rect x="58.64" y="16" width="34.72" height="26" fill="#4e79a7" rx="2" /><text x="76" y="10" text-anchor="middle" font-family="sans-serif" font-size="11" font-weight="normal" fill="#333333">10</text><text x="76" y="58" text-anchor="middle" font-family="sans-serif" font-size="11" font-weight="normal" fill="#333333">A</text></svg>
    ),
  )
}

///|
test "line_chart renders a polyline through its points" {
  inspect(
    @mooncharts.line_chart([(0.0, 0.0), (1.0, 2.0)], width=120.0, height=90.0),
    content=(
      #|<svg xmlns="http://www.w3.org/2000/svg" width="120" height="90" viewBox="0 0 120 90"><line x1="48" y1="50" x2="104" y2="50" stroke="#999999" stroke-width="1" /><text x="42" y="54" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">0</text><line x1="48" y1="41.5" x2="104" y2="41.5" stroke="#e6e6e6" stroke-width="1" /><text x="42" y="45.5" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">0.5</text><line x1="48" y1="33" x2="104" y2="33" stroke="#e6e6e6" stroke-width="1" /><text x="42" y="37" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">1</text><line x1="48" y1="24.5" x2="104" y2="24.5" stroke="#e6e6e6" stroke-width="1" /><text x="42" y="28.5" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">1.5</text><line x1="48" y1="16" x2="104" y2="16" stroke="#e6e6e6" stroke-width="1" /><text x="42" y="20" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">2</text><polyline points="48,50 104,16" fill="none" stroke="#4e79a7" stroke-width="2" stroke-linejoin="round" stroke-linecap="round" /><circle cx="48" cy="50" r="3" fill="#4e79a7" /><circle cx="104" cy="16" r="3" fill="#4e79a7" /></svg>
    ),
  )
}

///|
test "pie_chart renders one slice per positive value plus legend" {
  inspect(
    @mooncharts.pie_chart([("A", 3.0), ("B", 1.0)], width=200.0, height=120.0),
    content=(
      #|<svg xmlns="http://www.w3.org/2000/svg" width="200" height="120" viewBox="0 0 200 120"><path d="M 46 68 L 46 38 A 30 30 0 1 1 16 68 Z" fill="#4e79a7" /><rect x="96" y="49" width="12" height="12" fill="#4e79a7" rx="2" /><text x="114" y="58" text-anchor="start" font-family="sans-serif" font-size="11" font-weight="normal" fill="#333333">A (3)</text><path d="M 46 68 L 16 68 A 30 30 0 0 1 46 38 Z" fill="#f28e2b" /><rect x="96" y="69" width="12" height="12" fill="#f28e2b" rx="2" /><text x="114" y="78" text-anchor="start" font-family="sans-serif" font-size="11" font-weight="normal" fill="#333333">B (1)</text></svg>
    ),
  )
}

///|
test "area_chart fills the region under the line" {
  inspect(
    @mooncharts.area_chart([(0.0, 0.0), (1.0, 2.0)], width=120.0, height=90.0),
    content=(
      #|<svg xmlns="http://www.w3.org/2000/svg" width="120" height="90" viewBox="0 0 120 90"><line x1="48" y1="50" x2="104" y2="50" stroke="#999999" stroke-width="1" /><text x="42" y="54" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">0</text><line x1="48" y1="41.5" x2="104" y2="41.5" stroke="#e6e6e6" stroke-width="1" /><text x="42" y="45.5" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">0.5</text><line x1="48" y1="33" x2="104" y2="33" stroke="#e6e6e6" stroke-width="1" /><text x="42" y="37" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">1</text><line x1="48" y1="24.5" x2="104" y2="24.5" stroke="#e6e6e6" stroke-width="1" /><text x="42" y="28.5" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">1.5</text><line x1="48" y1="16" x2="104" y2="16" stroke="#e6e6e6" stroke-width="1" /><text x="42" y="20" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">2</text><polygon points="48,50 48,50 104,16 104,50" fill="#4e79a7" fill-opacity="0.18" /><polyline points="48,50 104,16" fill="none" stroke="#4e79a7" stroke-width="2" stroke-linejoin="round" stroke-linecap="round" /><circle cx="48" cy="50" r="3" fill="#4e79a7" /><circle cx="104" cy="16" r="3" fill="#4e79a7" /></svg>
    ),
  )
}

///|
test "scatter_chart renders one circle per point" {
  inspect(
    @mooncharts.scatter_chart(
      [(0.0, 0.0), (1.0, 1.0)],
      width=120.0,
      height=90.0,
    ),
    content=(
      #|<svg xmlns="http://www.w3.org/2000/svg" width="120" height="90" viewBox="0 0 120 90"><line x1="48" y1="50" x2="104" y2="50" stroke="#999999" stroke-width="1" /><text x="42" y="54" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">0</text><line x1="48" y1="43.2" x2="104" y2="43.2" stroke="#e6e6e6" stroke-width="1" /><text x="42" y="47.2" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">0.2</text><line x1="48" y1="36.4" x2="104" y2="36.4" stroke="#e6e6e6" stroke-width="1" /><text x="42" y="40.4" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">0.4</text><line x1="48" y1="29.6" x2="104" y2="29.6" stroke="#e6e6e6" stroke-width="1" /><text x="42" y="33.6" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">0.6</text><line x1="48" y1="22.8" x2="104" y2="22.8" stroke="#e6e6e6" stroke-width="1" /><text x="42" y="26.8" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">0.8</text><line x1="48" y1="16" x2="104" y2="16" stroke="#e6e6e6" stroke-width="1" /><text x="42" y="20" text-anchor="end" font-family="sans-serif" font-size="11" font-weight="normal" fill="#999999">1</text><circle cx="50.55" cy="50" r="4" fill="#4e79a7" fill-opacity="0.7" /><circle cx="101.45" cy="16" r="4" fill="#4e79a7" fill-opacity="0.7" /></svg>
    ),
  )
}

///|
test "dark theme paints a background rectangle" {
  let svg = @mooncharts.bar_chart(
    [("A", 1.0)],
    width=120.0,
    height=90.0,
    theme=@mooncharts.Theme::dark(),
  )
  inspect(svg.contains("#1e1e2e"), content="true")
}

///|
test "with_palette overrides the series colors" {
  let theme = @mooncharts.Theme::light().with_palette(["#ff0000", "#00ff00"])
  let svg = @mooncharts.bar_chart([("A", 1.0), ("B", 2.0)], theme~)
  inspect(svg.contains("#ff0000"), content="true")
  inspect(svg.contains("#00ff00"), content="true")
}

///|
test "line_chart_multi draws one colored series per entry plus a legend" {
  let svg = @mooncharts.line_chart_multi([
    ("A", [(0.0, 1.0), (1.0, 2.0)]),
    ("B", [(0.0, 2.0), (1.0, 1.0)]),
  ])
  inspect(svg.has_prefix("<svg"), content="true")
  // Two distinct series colors from the palette.
  inspect(svg.contains("#4e79a7"), content="true")
  inspect(svg.contains("#f28e2b"), content="true")
}

///|
test "bar_chart_grouped renders side-by-side bars for each series" {
  let svg = @mooncharts.bar_chart_grouped(["Q1", "Q2"], [
    ("2024", [10.0, 20.0]),
    ("2025", [15.0, 25.0]),
  ])
  inspect(svg.has_prefix("<svg"), content="true")
  inspect(svg.contains("#4e79a7"), content="true")
  inspect(svg.contains("#f28e2b"), content="true")
}
