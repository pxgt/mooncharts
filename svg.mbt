// Low-level SVG building blocks. Everything here turns typed data into a
// well-formed SVG string, so the rest of the library never hand-writes markup.

///|
/// Format a number with an SI suffix: `1_200` -> `"1.2k"`, `3_400_000` ->
/// `"3.4M"`, `0.0012` -> `"1.2m"`. Values below 1000 (and above 1/1000) keep
/// their plain `num` form. Handy for compact axis labels and data labels.
///
/// # Example
/// ```mbt check
/// test {
///   inspect(@mooncharts.format_si(1200.0), content="1.2k")
///   inspect(@mooncharts.format_si(3400000.0), content="3.4M")
///   inspect(@mooncharts.format_si(-52000.0), content="-52k")
///   inspect(@mooncharts.format_si(42.0), content="42")
/// }
/// ```
pub fn format_si(x : Double) -> String {
  if x == 0.0 {
    return "0"
  }
  let neg = x < 0.0
  let mut v = if neg { -x } else { x }
  let big = ["", "k", "M", "G", "T"]
  let small = ["", "m", "µ", "n", "p"]
  let sign = if neg { "-" } else { "" }
  if v >= 1000.0 {
    let mut i = 0
    while v >= 1000.0 && i < big.length() - 1 {
      v = v / 1000.0
      i += 1
    }
    sign + num(v) + big[i]
  } else if v < 1.0 {
    let mut i = 0
    while v < 1.0 && i < small.length() - 1 {
      v = v * 1000.0
      i += 1
    }
    sign + num(v) + small[i]
  } else {
    sign + num(v)
  }
}

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
