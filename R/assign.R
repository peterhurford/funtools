#' In-place addition
#' @param x numeric. The first addend.
#' @param y numeric. The second addend.
#' @export
`%+=%` <- function(x, y) {
  result <- x + y
  assign(deparse(substitute(x)), result, envir = parent.frame(1))
  result
}

#' In-place subtraction.
#' @param x numeric. The minuend.
#' @param y numeric. The subtrahend.
#' @export
`%-=%` <- function(x, y) {
  result <- x - y
  assign(deparse(substitute(x)), result, envir = parent.frame(1))
  result
}

#' In-place division.
#' @param x numeric. The dividend.
#' @param y numeric. The divisor.
#' @export
`%/=%` <- function(x, y) {
  result <- x / y
  assign(deparse(substitute(x)), result, envir = parent.frame(1))
  result
}

#' In-place multiplication
#' @param x numeric. The multiplier.
#' @param y numeric. The multiplicand.
#' @export
`%*=%` <- function(x, y) {
  result <- x * y
  assign(deparse(substitute(x)), result, envir = parent.frame(1))
  result
}

#' In-place assignment, allowing for multiple values.
#' @param vars character. The variable names to assign to. Can be a single string or list of strings.
#' @param values object. The values to assign. Can be a single object or a list of objects.
#' @export
`%a-%` <- function(vars, values) {
  vars <- substitute(vars)
  if (length(vars) > 1) {
    vars <- lapply(vars, deparse)[-1]
    stopifnot(length(vars) == length(values))
    for (i in seq_along(vars)) {
      assign(vars[[i]], values[[i]], envir = parent.frame(5))
    }
  } else {
    assign(deparse(vars), values, envir = parent.frame(1))
  }
}
