// Treemap with the squarified layout algorithm (Bruls, Huizing & van Wijk):
// rows of cells are laid greedily along the shorter side of the remaining
// rectangle, keeping cell aspect ratios as close to 1 as possible.

///|
/// Worst (most elongated) aspect ratio a row with total area `row_sum`,
/// largest cell `row_max` and smallest cell `row_min` would have when laid
/// along a side of length `side`.
fn worst_aspect(
  row_sum : Double,
  row_max : Double,
  row_min : Double,
  side : Double,
) -> Double {
  let s2 = side * side
  let sum2 = row_sum * row_sum
  let a = s2 * row_max / sum2
  let b = sum2 / (s2 * row_min)
  if a > b {
    a
  } else {
    b
  }
}

///|
/// Squarified treemap layout: split the rectangle at `(x0, y0)` sized
/// `w0 × h0` into one cell per entry of `areas` (which must sum to
/// `w0 * h0`), returned in input order as `(x, y, width, height)`.
fn squarify(
  areas : Array[Double],
  x0 : Double,
  y0 : Double,
  w0 : Double,
  h0 : Double,
) -> Array[(Double, Double, Double, Double)] {
  let out : Array[(Double, Double, Double, Double)] = []
  let mut x = x0
  let mut y = y0
  let mut w = w0
  let mut h = h0
  let n = areas.length()
  let mut i = 0
  while i < n {
    // Grow the row while doing so improves the worst aspect ratio.
    let side = if w < h { w } else { h }
    let mut row_sum = areas[i]
    let mut row_max = areas[i]
    let mut row_min = areas[i]
    let mut j = i + 1
    let mut worst = worst_aspect(row_sum, row_max, row_min, side)
    while j < n {
      let a = areas[j]
      let ns = row_sum + a
      let nmax = if a > row_max { a } else { row_max }
      let nmin = if a < row_min { a } else { row_min }
      let nworst = worst_aspect(ns, nmax, nmin, side)
      if nworst <= worst {
        row_sum = ns
        row_max = nmax
        row_min = nmin
        worst = nworst
        j += 1
      } else {
        break
      }
    }
    // Fix the row along the shorter side and shrink the remaining rectangle.
    let t = row_sum / side
    if w < h {
      let mut cx = x
      for k in i..<j {
        let cw = areas[k] / t
        out.push((cx, y, cw, t))
        cx += cw
      }
      y += t
      h -= t
    } else {
      let mut cy = y
      for k in i..<j {
        let ch = areas[k] / t
        out.push((x, cy, t, ch))
        cy += ch
      }
      x += t
      w -= t
    }
    i = j
  }
  out
}

///|
/// Render a treemap as a standalone SVG document string: each
/// `(label, value)` becomes a cell whose area is proportional to its value,
/// laid out with the squarified algorithm (cells stay close to square).
/// Non-positive values are skipped. `title`, `width`, `height` and `theme`
/// are optional.
pub fn treemap(
  data : Array[(String, Double)],
  title? : String = "",
  width? : Double = 520.0,
  height? : Double = 340.0,
  theme? : Theme = Theme::light(),
) -> String {
  let pad = 12.0
  let top = if title == "" { pad } else { 40.0 }
  let plot_w = width - pad * 2.0
  let plot_h = height - top - pad
  let body = StringBuilder::new()
  body.write_string(background_rect(theme, width, height))
  // Keep only positive entries; remember labels and values.
  let items : Array[(String, Double)] = []
  let mut total = 0.0
  for d in data {
    if d.1 > 0.0 {
      items.push(d)
      total += d.1
    }
  }
  let n = items.length()
  if n > 0 && total > 0.0 && plot_w > 0.0 && plot_h > 0.0 {
    // Squarify expects descending areas: sort indices by value (insertion
    // sort; treemaps are small).
    let order : Array[Int] = []
    for i in 0..<n {
      order.push(i)
    }
    for i in 1..<n {
      let key = order[i]
      let kv = items[key].1
      let mut j = i - 1
      while j >= 0 && items[order[j]].1 < kv {
        order[j + 1] = order[j]
        j -= 1
      }
      order[j + 1] = key
    }
    let areas : Array[Double] = []
    for k in 0..<n {
      areas.push(items[order[k]].1 / total * plot_w * plot_h)
    }
    let rects = squarify(areas, pad, top, plot_w, plot_h)
    for k in 0..<n {
      let (name, value) = items[order[k]]
      let (rx, ry, rw, rh) = rects[k]
      body.write_string(
        elem("rect", [
          ("x", num(rx)),
          ("y", num(ry)),
          ("width", num(rw)),
          ("height", num(rh)),
          ("fill", theme.color_at(k)),
          ("fill-opacity", "0.85"),
          (
            "stroke",
            if theme.background == "" {
              "#ffffff"
            } else {
              theme.background
            },
          ),
          ("stroke-width", "2"),
        ]),
      )
      // Label the cell when there is room for text.
      if rw > 46.0 && rh > 20.0 {
        body.write_string(
          label(rx + 6.0, ry + 15.0, name, anchor="start", fill="#ffffff"),
        )
        if rh > 36.0 {
          body.write_string(
            label(
              rx + 6.0,
              ry + 30.0,
              num(value),
              anchor="start",
              size=10,
              fill="#ffffff",
            ),
          )
        }
      }
    }
  }
  if title != "" {
    body.write_string(
      label(width / 2.0, 24.0, title, size=16, weight="bold", fill=theme.title),
    )
  }
  document(width, height, body.to_string())
}
