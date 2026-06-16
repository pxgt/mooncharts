// Shared visual defaults: the color palette and a text-label helper used by
// every chart so styling stays consistent in one place.

///|
/// Color palette cycled through for successive bars, slices, or series.
let palette : Array[String] = [
  "#4e79a7", "#f28e2b", "#e15759", "#76b7b2", "#59a14f", "#edc948", "#b07aa1", "#ff9da7",
  "#9c755f", "#bab0ac",
]

///|
/// Pick a palette color by index, wrapping around when there are more series
/// than colors.
fn color_at(i : Int) -> String {
  palette[i % palette.length()]
}

///|
/// A `<text>` label using the charts' default sans-serif styling. Centralizing
/// this keeps font choices consistent and the chart code free of repetition.
fn label(
  x : Double,
  y : Double,
  content : String,
  size? : Int = 11,
  anchor? : String = "middle",
  weight? : String = "normal",
  fill? : String = "#333333",
) -> String {
  text(x, y, content, [
    ("text-anchor", anchor),
    ("font-family", "sans-serif"),
    ("font-size", size.to_string()),
    ("font-weight", weight),
    ("fill", fill),
  ])
}
