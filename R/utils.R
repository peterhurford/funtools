#' @export
is_even <- function(x) x %% 2 == 0

#' @export
is_odd <- function(x) x %% 2 == 1


#' @export
is_upper <- function(x) identical(x, toupper(x))

#' @export
is_lower <- function(x) identical(x, tolower(x))


#' @export
is_true <- isTRUE

#' @export
is_false <- isFALSE <- function(x) { identical(x, FALSE) }


#' @export
`%==%` <- identical


#' @export
symdiff <- symmetric_difference <- function(xs, ys) {
  c(setdiff(xs, ys), setdiff(ys, xs))
}


#' @export
named <- function(xs) {
  !is.null(names(xs))
}

#' @export
unnamed <- Negate(named)


#' @export
dec <- function(x) x - 1

#' @export
inc <- function(x) x + 1


#' @export
div <- function(x, y) x %% y == 0


#' @export
grepv <- function(str, pattern) { grep(pattern, str, value = TRUE) }
