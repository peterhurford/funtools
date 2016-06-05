`%:>%` <- function(lhs, rhs) {
  if (length(rhs) > 1) {
    map(lhs, `[`, rhs)
  } else {
    map(lhs, `[[`, rhs)
  }
}
