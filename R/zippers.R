#' Zip two lists together into tuple vectors.
#' @param xs list. One list to zip.
#' @param ys list. Another list to zip.
#' @export
vzip <- function(xs, ys) { Map(c, xs, ys) }

#' Zip two lists together into a list of lists containing each element from
#'   both lists.
#' @param xs list. One list to zip.
#' @param ys list. Another list to zip.
#' @export
lzip <- function(xs, ys) { Map(list, xs, ys) }

#' Zip two lists together by a specific function.
#' @param xs list. One list to zip.
#' @param ys list. Another list to zip.
#' @param f function. A funciton that should take two arguments, iterating over
#'   each element of both lists.
#' @export
zip_with <- function(xs, ys, f) { Map(f, xs, ys) }

#' @rdname lzip
#' @export
`%+>%` <- lzip

#' @rdname vzip
#' @export
zip <- vzip

#' @rdname zip_with
#' @export
`%+/>%` <- function(xs, f) { lzip(xs, f(xs)) }
