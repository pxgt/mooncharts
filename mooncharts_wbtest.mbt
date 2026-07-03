// Whitebox tests for internal helpers that are not part of the public API.

///|
test "nice_ticks turns a 0..240 range into rounded, evenly spaced ticks" {
  let (lo, hi, ticks) = nice_ticks(0.0, 240.0, 5)
  inspect(
    lo,
    content=(
      #|0
    ),
  )
  inspect(
    hi,
    content=(
      #|300
    ),
  )
  debug_inspect(
    ticks,
    content=(
      #|[0, 100, 200, 300]
    ),
  )
}

///|
test "nice_ticks handles a small fractional range" {
  let (lo, hi, ticks) = nice_ticks(0.0, 0.8, 5)
  inspect(
    lo,
    content=(
      #|0
    ),
  )
  inspect(
    hi,
    content=(
      #|0.8
    ),
  )
  debug_inspect(
    ticks,
    content=(
      #|[0, 0.2, 0.4, 0.6000000000000001, 0.8]
    ),
  )
}

///|
test "hist_counts distributes samples into the right bins" {
  // 4 bins over [0, 4): 0.5→bin0, 1.5→bin1, 2.5→bin2, 3.5/3.9→bin3, 4.0 closes into bin3
  let counts = hist_counts([0.5, 1.5, 2.5, 3.5, 3.9, 4.0], 0.0, 4.0, 4)
  debug_inspect(counts, content="[1, 1, 1, 3]")
  // Out-of-range samples are ignored; degenerate range yields all zeros.
  debug_inspect(hist_counts([-1.0, 5.0], 0.0, 4.0, 2), content="[0, 0]")
  debug_inspect(hist_counts([1.0], 1.0, 1.0, 2), content="[0, 0]")
}

///|
test "lerp_color interpolates hex colors with clamping" {
  inspect(lerp_color("#000000", "#ffffff", 0.5), content="#808080")
  inspect(lerp_color("#000000", "#ffffff", 0.0), content="#000000")
  inspect(lerp_color("#000000", "#ffffff", 1.0), content="#ffffff")
  inspect(lerp_color("#000000", "#ffffff", 2.0), content="#ffffff")
  inspect(lerp_color("#4e79a7", "#4e79a7", 0.3), content="#4e79a7")
}

///|
test "nice_ticks guards a degenerate (zero-width) range" {
  let (lo, hi, _) = nice_ticks(5.0, 5.0, 5)
  inspect(
    lo,
    content=(
      #|5
    ),
  )
  inspect(
    hi > lo,
    content=(
      #|true
    ),
  )
}
