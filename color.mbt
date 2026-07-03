// Color helpers for continuous color scales (used by the heatmap).

///|
/// Value of one hex digit; anything else counts as 0.
fn hex_digit(c : Char) -> Int {
  match c {
    '0'..='9' => c.to_int() - 48
    'a'..='f' => c.to_int() - 87
    'A'..='F' => c.to_int() - 55
    _ => 0
  }
}

///|
/// Parse a "#rrggbb" color into `(r, g, b)`. Malformed input degrades to black.
fn parse_hex_color(s : String) -> (Int, Int, Int) {
  if s.length() != 7 {
    return (0, 0, 0)
  }
  let d = fn(i : Int) -> Int {
    match s.get_char(i) {
      Some(c) => hex_digit(c)
      None => 0
    }
  }
  (d(1) * 16 + d(2), d(3) * 16 + d(4), d(5) * 16 + d(6))
}

///|
/// Two lowercase hex digits for a channel value clamped to 0..255.
fn hex2(v : Int) -> String {
  let chars = "0123456789abcdef"
  let v = if v < 0 { 0 } else if v > 255 { 255 } else { v }
  let sb = StringBuilder::new()
  match (chars.get_char(v / 16), chars.get_char(v % 16)) {
    (Some(h), Some(l)) => {
      sb.write_char(h)
      sb.write_char(l)
    }
    _ => sb.write_string("00")
  }
  sb.to_string()
}

///|
/// Linear interpolation between two "#rrggbb" colors; `t` is clamped to
/// `[0, 1]` (`0` gives `a`, `1` gives `b`).
fn lerp_color(a : String, b : String, t : Double) -> String {
  let t = if t < 0.0 { 0.0 } else if t > 1.0 { 1.0 } else { t }
  let (ar, ag, ab) = parse_hex_color(a)
  let (br, bg, bb) = parse_hex_color(b)
  let mix = fn(x : Int, y : Int) -> Int {
    (x.to_double() + (y - x).to_double() * t).round().to_int()
  }
  "#" + hex2(mix(ar, br)) + hex2(mix(ag, bg)) + hex2(mix(ab, bb))
}
