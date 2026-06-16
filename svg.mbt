// Low-level SVG building blocks. Everything here turns typed data into a
// well-formed SVG string, so the rest of the library never hand-writes markup.

///|
/// Escape the XML special characters in text or attribute content so that the
/// resulting SVG string stays well-formed.
pub fn escape(s : String) -> String {
  let sb = StringBuilder::new()
  for c in s {
    match c {
      '&' => sb.write_string("&amp;")
      '<' => sb.write_string("&lt;")
      '>' => sb.write_string("&gt;")
      '"' => sb.write_string("&quot;")
      '\'' => sb.write_string("&#39;")
      _ => sb.write_char(c)
    }
  }
  sb.to_string()
}

///|
/// Format a `Double` as a compact SVG coordinate: rounded to at most two
/// decimals, with trailing zeros and a redundant ".0" dropped (`10.0` -> `"10"`,
/// `10.5` -> `"10.5"`, `43.929` -> `"43.93"`). Manual formatting avoids the
/// float artifacts that plain `to_string` can produce.
pub fn num(x : Double) -> String {
  let neg = x < 0.0
  let abs = if neg { -x } else { x }
  let hundredths = (abs * 100.0).round().to_int() // value scaled to 1/100 units
  let whole = hundredths / 100
  let frac = hundredths % 100
  let sign = if neg && hundredths != 0 { "-" } else { "" }
  if frac == 0 {
    sign + whole.to_string()
  } else if frac % 10 == 0 {
    sign + whole.to_string() + "." + (frac / 10).to_string()
  } else if frac < 10 {
    sign + whole.to_string() + ".0" + frac.to_string()
  } else {
    sign + whole.to_string() + "." + frac.to_string()
  }
}

///|
/// Render `(name, value)` pairs into ` name="value"` fragments, escaping the
/// values. An empty list renders to the empty string.
fn render_attrs(attrs : Array[(String, String)]) -> String {
  let sb = StringBuilder::new()
  for pair in attrs {
    let (k, v) = pair
    sb.write_string(" ")
    sb.write_string(k)
    sb.write_string("=\"")
    sb.write_string(escape(v))
    sb.write_string("\"")
  }
  sb.to_string()
}

///|
/// A self-closing SVG element such as `<rect x="0" ... />`.
pub fn elem(tag : String, attrs : Array[(String, String)]) -> String {
  "<" + tag + render_attrs(attrs) + " />"
}

///|
/// A container element wrapping inner markup, e.g. `<g ...>...</g>`.
pub fn container(
  tag : String,
  attrs : Array[(String, String)],
  inner : String,
) -> String {
  "<" + tag + render_attrs(attrs) + ">" + inner + "</" + tag + ">"
}

///|
/// A `<text>` element anchored at `(x, y)` with escaped text content.
pub fn text(
  x : Double,
  y : Double,
  content : String,
  attrs : Array[(String, String)],
) -> String {
  let base : Array[(String, String)] = [("x", num(x)), ("y", num(y))]
  for pair in attrs {
    base.push(pair)
  }
  "<text" + render_attrs(base) + ">" + escape(content) + "</text>"
}

///|
/// Wrap `body` in a root `<svg>` element with the given pixel size and the
/// standard namespace, producing a standalone, browser-renderable document.
pub fn document(width : Double, height : Double, body : String) -> String {
  let attrs : Array[(String, String)] = [
    ("xmlns", "http://www.w3.org/2000/svg"),
    ("width", num(width)),
    ("height", num(height)),
    ("viewBox", "0 0 " + num(width) + " " + num(height)),
  ]
  container("svg", attrs, body)
}
