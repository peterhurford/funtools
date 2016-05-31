is_even <- function(x) x %% 2 == 0

is_odd <- function(x) x %% 2 == 1

is_upper <- function(x) identical(x, toupper(x))

is_lower <- function(x) identical(x, tolower(x))


is_true <- isTRUE

is_false <- isFALSE <- function(x) { identical(x, FALSE) }


`%==%` <- identical
