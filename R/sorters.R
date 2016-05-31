sort_keys <- function(xs) {
  if (unnamed(xs)) { return(xs) }
  xs[sort(names(xs))]
}
