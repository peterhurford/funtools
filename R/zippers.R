#' @export
vzip <- zip <- function(xs, ys) { Map(c, xs, ys) }

#' @export
lzip <- function(xs, ys) { Map(list, xs, ys) }

#' @export
zip_with <- function(xs, ys, f) { Map(f, xs, ys) }

#' @export
`%+>%` <- lzip

#' @export
`%+/>%` <- function(xs, f) { lzip(xs, f(xs)) }
