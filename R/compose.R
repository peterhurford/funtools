#' @eport
fandcompose <- `%&>%` <- function(f1, f2) { function(...) { f1(...) && f2(...) }}

#' @eport
forcompose <- `%|>%` <- function(f1, f2) { function(...) { f1(...) || f2(...) }}


#' @eport
`%|all%` <- `%|%` <- compose_all <- function(x, y) {
  if (is.null(x) || is.na(x) || length(x) == 0) { y } else { x }
}

#' @eport
`%|0%` <- compose_zero <- function(x, y) { if (length(x) == 0) { y } else { x } }

#' @eport
`%|null%` <- `%||%` <- compose_null <- function(x, y) { if (is.null(x)) { y } else { x } }

#' @eport
`%|na%` <- `%|||%` <- compose_na <- function(x, y) { if (is.na(x)) { y } else { x } }
