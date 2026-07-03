///|
/// Build a small gallery of every chart type and print it as an HTML fragment.
/// Redirect it into a page to view in a browser, e.g.
///   moon run cmd/main > examples/gallery.html
fn main {
  let charts : Array[String] = [
    @mooncharts.bar_chart(
      [
        ("Mon", 120.0),
        ("Tue", 200.0),
        ("Wed", 150.0),
        ("Thu", 80.0),
        ("Fri", 240.0),
        ("Sat", 90.0),
        ("Sun", 60.0),
      ],
      title="Weekly Active Users",
      width=520.0,
      height=300.0,
    ),
    @mooncharts.line_chart(
      [
        (1.0, 12.0),
        (2.0, 19.0),
        (3.0, 15.0),
        (4.0, 25.0),
        (5.0, 22.0),
        (6.0, 30.0),
        (7.0, 28.0),
      ],
      title="Monthly Revenue ($k)",
      width=520.0,
      height=300.0,
    ),
    @mooncharts.pie_chart(
      [("Chrome", 65.0), ("Safari", 18.0), ("Edge", 10.0), ("Firefox", 7.0)],
      title="Browser Market Share",
      width=420.0,
      height=300.0,
    ),
    @mooncharts.pie_chart(
      [
        ("Organic", 45.0),
        ("Direct", 25.0),
        ("Social", 20.0),
        ("Referral", 10.0),
      ],
      title="Traffic Sources",
      width=420.0,
      height=300.0,
      donut=0.6,
    ),
    @mooncharts.scatter_chart(
      [
        (2.0, 55.0),
        (3.0, 62.0),
        (3.5, 68.0),
        (4.0, 71.0),
        (4.5, 74.0),
        (5.0, 80.0),
        (5.5, 78.0),
        (6.0, 88.0),
        (6.5, 90.0),
        (7.0, 95.0),
      ],
      title="Study Hours vs Score",
      width=420.0,
      height=300.0,
    ),
    @mooncharts.area_chart(
      [
        (1.0, 30.0),
        (2.0, 45.0),
        (3.0, 38.0),
        (4.0, 62.0),
        (5.0, 70.0),
        (6.0, 85.0),
      ],
      title="Daily Signups",
      width=520.0,
      height=300.0,
    ),
    @mooncharts.bar_chart(
      [("Q1", 88.0), ("Q2", 122.0), ("Q3", 105.0), ("Q4", 153.0)],
      title="Quarterly Revenue (dark theme)",
      width=420.0,
      height=300.0,
      theme=@mooncharts.Theme::dark(),
    ),
    @mooncharts.line_chart_multi(
      [
        (
          "Product A",
          [(1.0, 20.0), (2.0, 35.0), (3.0, 30.0), (4.0, 48.0), (5.0, 55.0)],
        ),
        (
          "Product B",
          [(1.0, 12.0), (2.0, 18.0), (3.0, 28.0), (4.0, 26.0), (5.0, 40.0)],
        ),
      ],
      title="Revenue by Product ($k)",
      width=520.0,
      height=320.0,
    ),
    @mooncharts.bar_chart_grouped(
      ["Q1", "Q2", "Q3", "Q4"],
      [
        ("2024", [88.0, 122.0, 105.0, 153.0]),
        ("2025", [110.0, 140.0, 130.0, 175.0]),
      ],
      title="Quarterly Revenue: 2024 vs 2025",
      width=520.0,
      height=320.0,
    ),
    @mooncharts.bar_chart_stacked(
      ["Q1", "Q2", "Q3", "Q4"],
      [
        ("Online", [40.0, 55.0, 48.0, 70.0]),
        ("Retail", [30.0, 35.0, 40.0, 50.0]),
        ("Wholesale", [18.0, 22.0, 17.0, 33.0]),
      ],
      title="Revenue by Channel (stacked)",
      width=520.0,
      height=320.0,
    ),
    @mooncharts.radar_chart(
      ["Speed", "Power", "Range", "Defense", "Magic", "Luck"],
      [
        ("Warrior", [9.0, 8.0, 4.0, 9.0, 2.0, 5.0]),
        ("Mage", [4.0, 6.0, 9.0, 3.0, 10.0, 6.0]),
      ],
      title="Character Stats",
      width=460.0,
      height=380.0,
    ),
    @mooncharts.histogram(
      [
        4.2, 4.8, 5.1, 5.3, 5.5, 5.6, 5.8, 5.9, 6.0, 6.1, 6.1, 6.2, 6.3, 6.4, 6.6,
        6.8, 7.0, 7.1, 7.4, 7.9, 8.3, 8.8,
      ],
      bins=8,
      title="Response Time Distribution (ms)",
      width=520.0,
      height=300.0,
    ),
    @mooncharts.heatmap(
      ["Mon", "Wed", "Fri"],
      ["9am", "12pm", "3pm", "6pm"],
      [
        [12.0, 45.0, 38.0, 20.0],
        [25.0, 62.0, 54.0, 31.0],
        [18.0, 48.0, 70.0, 42.0],
      ],
      title="Traffic by Hour",
      width=460.0,
      height=300.0,
    ),
    @mooncharts.bar_chart_horizontal(
      [
        ("Rust", 88.0),
        ("MoonBit", 82.0),
        ("Go", 75.0),
        ("TypeScript", 71.0),
        ("Python", 66.0),
      ],
      title="Language Satisfaction (%)",
      width=460.0,
      height=300.0,
    ),
    @mooncharts.box_plot(
      [
        ("API", [42.0, 45.0, 48.0, 50.0, 52.0, 55.0, 58.0, 61.0, 95.0]),
        ("Web", [55.0, 60.0, 62.0, 65.0, 68.0, 72.0, 75.0, 80.0]),
        ("Batch", [30.0, 33.0, 35.0, 36.0, 38.0, 40.0, 44.0, 70.0]),
      ],
      title="Latency by Service (ms)",
      width=460.0,
      height=320.0,
    ),
    @mooncharts.area_chart_stacked(
      [1.0, 2.0, 3.0, 4.0, 5.0, 6.0],
      [
        ("Mobile", [20.0, 26.0, 30.0, 34.0, 40.0, 46.0]),
        ("Desktop", [35.0, 36.0, 34.0, 38.0, 40.0, 42.0]),
        ("Tablet", [8.0, 9.0, 10.0, 9.0, 11.0, 12.0]),
      ],
      title="Sessions by Device (stacked)",
      width=520.0,
      height=320.0,
    ),
  ]
  let sb = StringBuilder::new()
  sb.write_string(
    "<div style=\"display:flex;flex-wrap:wrap;gap:16px;align-items:flex-start;\">",
  )
  for c in charts {
    sb.write_string(
      "<div style=\"background:#ffffff;border:1px solid #e6e6e6;border-radius:12px;padding:12px;\">",
    )
    sb.write_string(c)
    sb.write_string("</div>")
  }
  sb.write_string("</div>")
  println(sb.to_string())
}
