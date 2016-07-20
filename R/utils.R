is_even <- function(x) x %% 2 == 0

is_odd <- function(x) x %% 2 == 1

is_upper <- function(x) identical(x, toupper(x))

is_lower <- function(x) identical(x, tolower(x))


is_true <- isTRUE

is_false <- isFALSE <- function(x) { identical(x, FALSE) }


`%==%` <- identical


symdiff <- symmetric_difference <- function(xs, ys) {
  c(setdiff(xs, ys), setdiff(ys, xs))
}


named <- function(xs) {
  !is.null(names(xs))
}

unnamed <- Negate(named)

dec <- function(x) x - 1
inc <- function(x) x + 1


div <- function(x, y) x %% y == 0

grepv <- function(str, pattern) { grep(pattern, str, value = TRUE) }
