#' Determine whether a number is even.
#' @param x numeric. The number to look at.
#' @export
is_even <- function(x) x %% 2 == 0

#' Determine whether a number is odd.
#' @param x numeric. The number to look at.
#' @export
is_odd <- function(x) x %% 2 == 1


#' Determine whether a character is uppercase.
#' @param x character. The character to look at.
#' @export
is_upper <- function(x) identical(x, toupper(x))

#' Determine whether a character is lowercase.
#' @param x character. The character to look at.
#' @export
is_lower <- function(x) identical(x, tolower(x))


#' Determine whether an object is TRUE.
#' @param x object. The object to look at.
#' @export
is_true <- function(x) { isTRUE(x) }

#' Determine whether an object is FALSE.
#' @param x object. The object to look at.
#' @export
is_false <- isFALSE <- function(x) { identical(x, FALSE) }


#' Determine whether two objects are identical.
#' @param x object. The object to compare.
#' @param y object. The other object to compare.
#' @export
`%==%` <- function(x, y) { identical(x, y) }


#' Symmetric difference
#' Find all the elements that are not in both sets.
#' @param xs list. The first list to look at.
#' @param ys list. The second element to look at.
#' @export
symdiff <- symmetric_difference <- function(xs, ys) {
  union(setdiff(xs, ys), setdiff(ys, xs))
}


#' Determine whether a list is named.
#' @param xs list. The list to look at.
#' @export
named <- function(xs) {
  !is.null(names(xs))
}

#' Determine whether a list is unnamed.
#' @param xs list. The list to look at.
#' @export
unnamed <- function(xs) { Negate(named)(xs) }


#' Decrement a number by one.
#' @param x numeric. The number to decrement.
#' @export
dec <- function(x) x - 1

#' Increment a number by one.
#' @param x numeric. The number to increment.
#' @export
inc <- function(x) x + 1


#' Determine if a dividend is evenly divisible by a divisor.
#' @param x numeric. The dividend.
#' @param y numeric. The divisor.
#' @export
div <- function(x, y) x %% y == 0


#' Find all the matches of a pattern within a string.
#' @param haystack character. The string to search within.
#' @param needle character. The pattern to look for.
#' @param ... list. Additional arguments to pass to grep.
#' @export
grepv <- function(haystack, needle, ...) { grep(needle, haystack, value = TRUE, ...) }
