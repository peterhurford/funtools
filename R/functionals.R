#' @export
map <- function(xs, f, ...) { lapply(xs, f, ...) }

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
nfilter <- function(xs, f) { l2[Filter(f, names(xs))] }

#' @import magrittr
#' @export
`%/>%` <- function(lhs, rhs) {
  if (is.list(rhs)) {
    do.call(map, c(list(lhs), rhs))
  } else {
    lhs %>% map(rhs)
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
`%\\>%` <- function(lhs, rhs) { lhs %>% vmap(rhs) }

#' @export
#' @import magrittr
flatmap <- function(xs, f) { map(xhs, f) %>% flatten }

#' @export
`%f/>%` <- function(lhs, rhs) { lhs %>% flatmap(rhs) }

#' @export
filtermap <- function(xs, f) { xs[vmap(xs, f)] }

#' @export
`%:/>%` <- function(lhs, rhs) { lhs %>% filtermap(rhs) }

#' @export
reducemap <- function(xs, f) { map(xs, curry(reduce, f = f)) }

#' @export
`%_/>%` <- function(lhs, rhs) { lhs %>% reducemap(rhs) }

#' @export
flip <- function(f) { function(...) { do.call(f, rev(list(...))) } }
# subtract(3, 5)
# -2
# flip(subtract)(3, 5)
# 2

#' @export
accumulate <- function(xs, f) {
  outs <- list(head(xs, 1))
  f2 <- function(...) {
    out <- f(...)
    outs <<- append(outs, out)
    out
  }
  reduce(xs, f2)
  outs
}
# accumulate(seq(5), sum)
# # cumsum <- curry(accumulate, f = sum)

#' @export
self_map <- function(xs, f) { f(xs, stretch(xs, length(xs))) }

#' @export
filterassign <- function(data, filter, value) {
  data[filter(data)] <- value 
}

#' @export
`%:<>%` <- function(lhs, rhs) {
  filterassign(lhs, rhs[[1]], rhs[[2]])
}

# p %:<>% list(is.infinite, NA)

# l <- list(Alice = list(20, 15, 30), Bob = list(10, 35))

# R-EXP> map(l, sum)
# $Alice
# [1] 65

# $Bob
# [1] 45

# R-EXP> nmap(l, tolower)
# $alice
# $alice[[1]]
# [1] 20

# $alice[[2]]
# [1] 15

# $alice[[3]]
# [1] 30


# $bob
# $bob[[1]]
# [1] 10

# $bob[[2]]
# [1] 35

# filter(l2, is_even)
# $b
# [1] 2

# $D
# [1] 4

# nfilter(l2, is_upper)
# $C
# [1] 3

# $D
# [1] 4
