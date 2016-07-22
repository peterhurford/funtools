#' Infix operator for appending to a list.
#' @param xs list. The list to append to.
#' @param x object. The object to append to the list.
#' @export
`%<%` <- function(xs, x) { append(xs, x) }

#' Infix operator for in-place appending to list.
#' @param xs list. The list to append to.
#' @param y object. The object to append to the list.
#' @export
`%<<%` <- function(xs, y) {
  result <- append(xs, y)
  assign(deparse(substitute(xs)), result, envir = parent.frame(1))
  result
}
