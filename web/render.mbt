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
    "smoothline" =>
      @mooncharts.line_chart(xy, smooth=true, theme~, width=w, height=h)
    "candlestick" => {
      // Derive OHLC candles from consecutive slider values.
      let candles : Array[(String, Double, Double, Double, Double)] = []
      for i in 0..<labels.length() {
        let v = if i < values.length() { values[i] } else { 0.0 }
        let prev = if i == 0 || i > values.length() { v } else { values[i - 1] }
        let hi = if v > prev { v } else { prev }
        let lo = if v < prev { v } else { prev }
        candles.push((labels[i], prev, hi + 12.0, lo - 12.0, v))
      }
      @mooncharts.candlestick_chart(candles, theme~, width=w, height=h)
    }
    "waterfall" => {
      // Treat slider values as signed deltas around their mean.
      let m = @mooncharts.mean(values)
      let deltas : Array[(String, Double)] = []
      for i in 0..<labels.length() {
        let v = if i < values.length() { values[i] } else { 0.0 }
        deltas.push((labels[i], v - m))
      }
      @mooncharts.waterfall_chart(deltas, theme~, width=w, height=h)
    }
    "bubble" => {
      let pts : Array[(Double, Double, Double)] = []
      for i in 0..<values.length() {
        pts.push((i.to_double(), values[i], values[i]))
      }
      @mooncharts.bubble_chart(pts, theme~, width=w, height=h)
    }
    "hbar" => @mooncharts.bar_chart_horizontal(data, theme~, width=w, height=h)
    "stackedarea" => {
      let sxs : Array[Double] = []
      for i in 0..<values.length() {
        sxs.push(i.to_double())
      }
      @mooncharts.area_chart_stacked(
        sxs,
        [("Series 1", values), ("Series 2", values2)],
        theme~,
        width=w,
        height=h,
      )
    }
    "heatmap" => {
      // Fold the six slider values into a 2x3 matrix.
      let m : Array[Array[Double]] = [[], []]
      for i in 0..<values.length() {
        m[i % 2].push(values[i])
      }
      @mooncharts.heatmap(
        ["Row 1", "Row 2"],
        ["Col 1", "Col 2", "Col 3"],
        m,
        theme~,
        width=w,
        height=h,
      )
    }
    _ => @mooncharts.bar_chart(data, theme~, width=w, height=h)
  }
}
