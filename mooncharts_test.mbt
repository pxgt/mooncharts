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
      #|<svg xmlns="http://www.w3.org/2000/svg" width="120" height="90" viewBox="0 0 120 90"><line x1="48" y1="42" x2="104" y2="42" stroke="#888888" stroke-width="1" /><rect x="58.64" y="16" width="34.72" height="26" fill="#4e79a7" rx="2" /><text x="76" y="10" text-anchor="middle" font-family="sans-serif" font-size="11" font-weight="normal" fill="#333333">10</text><text x="76" y="58" text-anchor="middle" font-family="sans-serif" font-size="11" font-weight="normal" fill="#333333">A</text></svg>
    ),
  )
}

///|
test "line_chart renders a polyline through its points" {
  inspect(
    @mooncharts.line_chart([(0.0, 0.0), (1.0, 2.0)], width=120.0, height=90.0),
    content=(
      #|<svg xmlns="http://www.w3.org/2000/svg" width="120" height="90" viewBox="0 0 120 90"><line x1="48" y1="16" x2="48" y2="50" stroke="#cccccc" stroke-width="1" /><line x1="48" y1="50" x2="104" y2="50" stroke="#888888" stroke-width="1" /><polyline points="48,50 104,16" fill="none" stroke="#4e79a7" stroke-width="2" stroke-linejoin="round" stroke-linecap="round" /><circle cx="48" cy="50" r="3" fill="#4e79a7" /><circle cx="104" cy="16" r="3" fill="#4e79a7" /></svg>
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
test "scatter_chart renders one circle per point" {
  inspect(
    @mooncharts.scatter_chart(
      [(0.0, 0.0), (1.0, 1.0)],
      width=120.0,
      height=90.0,
    ),
    content=(
      #|<svg xmlns="http://www.w3.org/2000/svg" width="120" height="90" viewBox="0 0 120 90"><line x1="48" y1="16" x2="48" y2="50" stroke="#cccccc" stroke-width="1" /><line x1="48" y1="50" x2="104" y2="50" stroke="#888888" stroke-width="1" /><circle cx="50.55" cy="48.45" r="4" fill="#4e79a7" fill-opacity="0.7" /><circle cx="101.45" cy="17.55" r="4" fill="#4e79a7" fill-opacity="0.7" /></svg>
    ),
  )
}
