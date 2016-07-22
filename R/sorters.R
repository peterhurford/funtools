#' Sort a list by the names of that list.
#' @param xs list. The list to sort.
#' @export
sort_keys <- function(xs) {
  if (unnamed(xs)) { return(xs) }
  unnamed_xs <- xs[names(xs) == ""]
  named_xs <- xs[names(xs) != ""]
  c(named_xs[sort(names(named_xs))], unnamed_xs)
}
