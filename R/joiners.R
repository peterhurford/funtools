flatten <- function(xs) { as.list(unlist(xs)) }

compact <- function(xs) {
  filter(xs, function(x) !is.null(x) || !suppressWarnings(is.na(x)))
}

collapse <- function(str, collapse = "") {
  paste0(str, collapse = collapse)
}

join <- function(l, join = "") {
  collapse(unlist(l), collapse = join)
}
