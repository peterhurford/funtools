#' @eport
`%<%` <- append

#' @eport
`%<<%` <- function(x, y) {
  result <- append(x, y)
  assign(deparse(substitute(x)), result, envir = parent.frame(3))
  result
}
