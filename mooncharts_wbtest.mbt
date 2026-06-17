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
