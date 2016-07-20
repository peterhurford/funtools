#' Sort a list by the names of that list.
#' @param xs list. The list to sort.
#' @export
sort_keys <- function(xs) {
  if (unnamed(xs)) { return(xs) }
  xs[sort(names(xs))]
}
