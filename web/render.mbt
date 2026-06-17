///|
/// Render a chart to an SVG string for the browser demo. Called from JavaScript
/// with parallel `labels`/`values` arrays so the page can re-render live as the
/// user edits data. `kind` is one of "bar", "line", "area", "pie", "donut".
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
  let data : Array[(String, Double)] = []
  for i in 0..<labels.length() {
    let v = if i < values.length() { values[i] } else { 0.0 }
    data.push((labels[i], v))
  }
  let w = 640.0
  let h = 380.0
  let xy : Array[(Double, Double)] = []
  for i in 0..<data.length() {
    xy.push((i.to_double(), data[i].1))
  }
  match kind {
    "line" => @mooncharts.line_chart(xy, theme~, width=w, height=h)
    "area" => @mooncharts.area_chart(xy, theme~, width=w, height=h)
    "pie" => @mooncharts.pie_chart(data, theme~, width=w, height=h)
    "donut" =>
      @mooncharts.pie_chart(data, theme~, donut=0.55, width=w, height=h)
    _ => @mooncharts.bar_chart(data, theme~, width=w, height=h)
  }
}
