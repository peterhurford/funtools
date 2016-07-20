#' @export
flatten <- function(xs) { Reduce(append, xs, list()) }

#' @export
compact <- function(xs) {
  filter(xs, function(x) !is.null(x) && !suppressWarnings(is.na(x)))
}

#' @export
join <- function(l, join = "") {
  paste0(unlist(l), collapse = join)
}
