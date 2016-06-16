`%$>%` <- function(lhs, rhs) {
  if (length(lhs) == 1) { lhs <- list(lhs) }
  get_fn <- if (length(rhs) > 1) { `[` } else { `[[` }
  map(lhs, get_fn, rhs)
}
