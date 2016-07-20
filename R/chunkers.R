chunk <- function(xs, n) { unname(split(xs, ceiling(seq_along(xs) / n))) }

partition <- function(xs, f) {
  filtered <- filter(xs, f)
  list(filtered, setdiff(xs, filtered))
}
