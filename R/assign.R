`%+=%` <- function(x, y) {
  result <- x + y
  assign(deparse(substitute(x)), result, envir = parent.frame(3))
  result
}

`%-=%` <- function(x, y) {
  result <- x - y
  assign(deparse(substitute(x)), result, envir = parent.frame(3))
  result
}

`%/=%` <- function(x, y) {
  result <- x / y
  assign(deparse(substitute(x)), result, envir = parent.frame(3))
  result
}

`%*=%` <- function(x, y) {
  result <- x * y
  assign(deparse(substitute(x)), result, envir = parent.frame(3))
  result
}

`%<-%` <- function(vars, vals) {
  vars <- lapply(substitute(vars), deparse)[-1]
  for (i in seq_along(vars)) {
    assign(vars[[i]], vals[[i]], envir = parent.frame(3))
  }
}
