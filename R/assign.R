#' In-place addition
#' @param x numeric. The first addend.
#' @param y numeric. The second addend.
#' @export
`%+=%` <- function(x, y) {
  result <- x + y
  assign(deparse(substitute(x)), result, envir = parent.frame(3))
  result
}

#' In-place subtraction.
#' @param x numeric. The minuend.
#' @param y numeric. The subtrahend.
#' @export
`%-=%` <- function(x, y) {
  result <- x - y
  assign(deparse(substitute(x)), result, envir = parent.frame(3))
  result
}

#' In-place division.
#' @param x numeric. The dividend.
#' @param y numeric. The divisor.
#' @export
`%/=%` <- function(x, y) {
  result <- x / y
  assign(deparse(substitute(x)), result, envir = parent.frame(3))
  result
}

#' In-place multiplication
#' @param x numeric. The multiplier.
#' @param y numeric. The multiplicand.
#' @export
`%*=%` <- function(x, y) {
  result <- x * y
  assign(deparse(substitute(x)), result, envir = parent.frame(3))
  result
}

#' In-place assignment, allowing for multiple values.
#' @param vars character. The variable names to assign to. Can be a single string or list of strings.
#' @param value object. The values to assign. Can be a single object or a list of objects.
#' @export
`%a-%` <- function(vars, value) {
  vars <- lapply(substitute(vars), deparse)[-1]
  for (i in seq_along(vars)) {
    assign(vars[[i]], value[[i]], envir = parent.frame(3))
  }
}
