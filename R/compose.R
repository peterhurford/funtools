#' Compose two binary functions using and.
#' @param f1 function. A function to compose.
#' @param f2 function. A function to compose.
#' @return TRUE or FALSE whether the results of both functions are TRUE.
#' @export
fandcompose <- `%&>%` <- function(f1, f2) { function(...) { f1(...) && f2(...) }}

#' Compose two binary functions using or.
#' @param f1 function. A function to compose.
#' @param f2 function. A function to compose.
#' @return TRUE or FALSE whether the result of one or both functions is TRUE.
#' @export
forcompose <- `%|>%` <- function(f1, f2) { function(...) { f1(...) || f2(...) }}


#' Compose on NA, NULL, or lenth-0 (empty) values.
#' @param x object. This object will be returned if non-NA, non-NULL, non-empty.
#' @param y object. This object will be returned if x is NA, NULL, or empty.
#' @return either x or y.
#' @export
`%|all%` <- `%|%` <- compose_all <- function(x, y) {
  if (is.null(x) || is.na(x) || length(x) == 0) { y } else { x }
}

#' Compose on length-0 values.
#' @param x object. This object will be returned if non-empty.
#' @param y object. This object will be returned if empty.
#' @return either x or y.
#' @export
`%|0%` <- compose_zero <- function(x, y) { if (length(x) == 0) { y } else { x } }

#' Compose on NULL values.
#' @param x object. This object will be returned if non-NULL.
#' @param y object. This object will be returned if x is NULL.
#' @return either x or y.
#' @export
`%|null%` <- `%||%` <- compose_null <- function(x, y) { if (is.null(x)) { y } else { x } }

#' Compose on NA values.
#' @param x object. This object will be returned if non-NA.
#' @param y object. This object will be returned if x is NA.
#' @return either x or y.
#' @export
`%|na%` <- `%|||%` <- compose_na <- function(x, y) { if (is.na(x)) { y } else { x } }
