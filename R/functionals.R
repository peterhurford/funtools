#' @export
map <- function(xs, f, ...) { lapply(xs, f, ...) }

#' @export
innermap <- function(xs, f, ...) { lapply(xs, function(sxs) { lapply(sxs, f, ...) }) }

#' @export
vmap <- function(xs, f) { lapply(xs, function(x) { f(unlist(x)) }) }

#' @export
nmap <- function(xs, f) { setNames(xs, lapply(names(xs), f)) }

#' @export
reduce <- function(xs, f, init) { Reduce(f, xs, init) }

#' @export
reduce1 <- function(xs, f) { reduce(xs, f, 1) }

#' @export
filter <- valfilter <- function(xs, f) { UseMethod("filter") }

#' @export
filter.default <- function(xs, f) { Filter(f, xs) }

#' @export
nfilter <- function(xs, f) { xs[Filter(f, names(xs))] }

#' @export
find <- function(xs, f) { Find(f, xs) }

#' @export
position <- function(xs, f) { Position(f, xs) }

#' @import magrittr
#' @export
`%/>%` <- function(lhs, rhs) {
  if (is.list(rhs)) {
    do.call(map, c(list(lhs), rhs))
  } else {
    lhs %>% map(rhs)
  }
}

#' @import magrittr
#' @export
`%//>%` <- function(lhs, rhs) {
  if (is.list(rhs)) {
    do.call(innermap, c(list(lhs), rhs))
  } else {
    lhs %>% innermap(rhs)
  }
}

#' @export
`%:>%` <- function(lhs, rhs) { lhs %>% filter(rhs) }

#' @export
`%_>%` <- function(lhs, rhs) {
  if (is.list(rhs) && length(rhs) == 2) {
    lhs %>% reduce(rhs[[1]], rhs[[2]])
  } else {
    lhs %>% reduce(rhs)
  }
}

#' @export
`%\\>%` <- function(lhs, rhs) { unlist(lhs) %>% rhs }

#' @export
#' @import magrittr
flatmap <- function(xs, f) { map(xs, f) %>% flatten }

#' @export
`%f/>%` <- function(lhs, rhs) { lhs %>% flatmap(rhs) }

#' @export
filtermap <- function(xs, filter_f, map_f) {
  predicates <- which(unlist(map(xs, filter_f)))
  xs[predicates] <- map(xs[predicates], map_f)
  xs
}

#' @export
`%:/>%` <- function(lhs, rhs) { filtermap(lhs, rhs[[1]], rhs[[2]]) }

#' @export
reducemap <- function(xs, f) { map(xs, function(x) { reduce(x, f) }) }

#' @export
`%_/>%` <- function(lhs, rhs) { lhs %>% reducemap(rhs) }
