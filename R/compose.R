fandcompose <- `%&>%` <- function(f1, f2) { function(...) { f1(...) && f2(...) }}

forcompose <- `%|>%` <- function(f1, f2) { function(...) { f1(...) || f2(...) }}
