#' @eport
chunk <- function(xs, n) { unname(split(xs, ceiling(seq_along(xs) / n))) }

#' @eport
partition <- function(xs, f) {
  filtered <- filter(xs, f)
  list(filtered, setdiff(xs, filtered))
}
