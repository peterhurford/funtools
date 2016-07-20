#' Take a list of lists and return a list.
#' @param xs list. The list to flatten.
#' @export
flatten <- function(xs) { Reduce(append, xs, list()) }

#' Remove all NAs and NULLs from a list.
#' @param xs list. The list to compact.
#' @export
compact <- function(xs) {
  filter(xs, function(x) !is.null(x) && !suppressWarnings(is.na(x)))
}

#' Join a list of strings together into one string.
#' @param l list. The list to join.
#' @param join character. The string to join on.
#' @export
join <- function(l, join = "") {
  paste0(unlist(l), collapse = join)
}
