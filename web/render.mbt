///|
/// Render a chart to an SVG string for the browser demo. Called from JavaScript
/// with parallel `labels`/`values` arrays so the page can re-render live as the
/// user edits data. `kind` selects the chart type; for the multi-series types
/// ("multiline", "grouped", "stacked", "radar") a second series is derived from
/// the values so the same sliders can drive them.
pub fn render(
  kind : String,
  labels : Array[String],
  values : Array[Double],
  dark : Bool,
) -> String {
  let theme = if dark {
    @mooncharts.Theme::dark()
  } else {
    @mooncharts.Theme::light()
  }
  let w = 640.0
  let h = 380.0
  let data : Array[(String, Double)] = []
  let xy : Array[(Double, Double)] = []
  for i in 0..<labels.length() {
    let v = if i < values.length() { values[i] } else { 0.0 }
    data.push((labels[i], v))
    xy.push((i.to_double(), v))
  }
  // A derived second series so the multi-series charts have something to compare.
  let values2 = values.map(fn(v) { v * 0.6 + 12.0 })
  let xy2 : Array[(Double, Double)] = []
  for i in 0..<values2.length() {
    xy2.push((i.to_double(), values2[i]))
  }
  let two : Array[(String, Array[Double])] = [
    ("Series 1", values),
    ("Series 2", values2),
  ]
  match kind {
    "line" => @mooncharts.line_chart(xy, theme~, width=w, height=h)
    "area" => @mooncharts.area_chart(xy, theme~, width=w, height=h)
    "scatter" => @mooncharts.scatter_chart(xy, theme~, width=w, height=h)
    "pie" => @mooncharts.pie_chart(data, theme~, width=w, height=h)
    "donut" =>
      @mooncharts.pie_chart(data, theme~, donut=0.55, width=w, height=h)
    "multiline" =>
      @mooncharts.line_chart_multi(
        [("Series 1", xy), ("Series 2", xy2)],
        theme~,
        width=w,
        height=h,
      )
    "grouped" =>
      @mooncharts.bar_chart_grouped(labels, two, theme~, width=w, height=h)
    "stacked" =>
      @mooncharts.bar_chart_stacked(labels, two, theme~, width=w, height=h)
    "radar" => @mooncharts.radar_chart(labels, two, theme~, width=w, height=h)
    _ => @mooncharts.bar_chart(data, theme~, width=w, height=h)
  }
}
