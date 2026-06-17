// Theming: a cohesive bundle of colors applied across a chart. Construct one
// with `Theme::light()` or `Theme::dark()`, optionally swap the series palette,
// and pass it to any chart via the `theme?` argument.

///|
/// Visual theme shared by every chart. `background` of `""` means transparent
/// (no background rectangle is drawn).
pub(all) struct Theme {
  palette : Array[String] // series / category colors, cycled by index
  background : String // page background, "" for transparent
  grid : String // gridline color
  axis : String // baseline and axis-tick label color
  text : String // data value and category label color
  title : String // chart title color
}

///|
let light_palette : Array[String] = [
  "#4e79a7", "#f28e2b", "#e15759", "#76b7b2", "#59a14f", "#edc948", "#b07aa1", "#ff9da7",
  "#9c755f", "#bab0ac",
]

///|
let dark_palette : Array[String] = [
  "#6ea8e0", "#f6a04d", "#ef6f70", "#8fd4cd", "#7fc06a", "#f2d65c", "#c79bc0", "#ffb3bb",
  "#bd9279", "#cfcac4",
]

///|
/// The default light theme: transparent background with dark text.
pub fn Theme::light() -> Theme {
  {
    palette: light_palette,
    background: "",
    grid: "#e6e6e6",
    axis: "#999999",
    text: "#333333",
    title: "#222222",
  }
}

///|
/// A dark theme: dark background, light text and a brighter palette.
pub fn Theme::dark() -> Theme {
  {
    palette: dark_palette,
    background: "#1e1e2e",
    grid: "#39394d",
    axis: "#8888a0",
    text: "#cdd0e0",
    title: "#f0f0f8",
  }
}

///|
/// Return a copy of this theme using a different series palette.
pub fn Theme::with_palette(self : Theme, palette : Array[String]) -> Theme {
  { ..self, palette, }
}

///|
/// Pick a series color by index, wrapping around when there are more series
/// than palette entries.
fn Theme::color_at(self : Theme, i : Int) -> String {
  self.palette[i % self.palette.length()]
}

///|
/// A background rectangle covering the whole canvas, or `""` when the theme's
/// background is transparent.
fn background_rect(theme : Theme, width : Double, height : Double) -> String {
  if theme.background == "" {
    ""
  } else {
    elem("rect", [
      ("x", "0"),
      ("y", "0"),
      ("width", num(width)),
      ("height", num(height)),
      ("fill", theme.background),
    ])
  }
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
