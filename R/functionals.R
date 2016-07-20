#' Iterate a function over a list.
#' @param xs list. The list to iterate over.
#' @param f function. The function to apply.
#' @param ... list. Additional optional arguments to pass to lapply.
#' @export
map <- function(xs, f, ...) { lapply(xs, f, ...) }

#' Iterate a function over each sublist in a list of lists.
#' @param xs list. The list-of-lists to iterate over.
#' @param f function. The function to apply.
#' @param ... list. Additional optional arguments to pass to lapply.
#' @export
innermap <- function(xs, f, ...) { lapply(xs, function(sxs) { lapply(sxs, f, ...) }) }

#' Iterate a function over the values of a list.
#' @param xs list. The list to iterate over.
#' @param f function. The function to apply.
#' @export
vmap <- function(xs, f) { lapply(xs, function(x) { f(unlist(x)) }) }

#' Iterate a function over the names of a list.
#' @param xs list. The list to iterate over.
#' @param f function. The function to apply.
#' @export
nmap <- function(xs, f) { setNames(xs, lapply(names(xs), f)) }

#' Recursively recombine values of a list.
#' @param xs list. The list to reduce.
#' @param f function. The reducing function to apply, taking two values and producing one value.
#' @param init object. An optional initialization value to start reducing.
#' @export
reduce <- function(xs, f, init) { Reduce(f, xs, init) }

#' Return only the values of a list that meet a certain predicate.
#' @param xs list. The list to filter.
#' @param f function. The predicate function to apply. It should return TRUE or FALSE for each element of the list.
#' @export
filter <- valfilter <- function(xs, f) { UseMethod("filter") }

#' @rdname filter
#' @export
filter.default <- function(xs, f) { Filter(f, xs) }

#' Return only the values of a list where the names of that list meet a certain predicate.
#' @param xs list. The list to filter.
#' @param f function. The predicate function to apply. It should return TRUE or FALSE for each name element of the list.
#' @export
nfilter <- function(xs, f) { xs[Filter(f, names(xs))] }

#' Returns the first value of a list that meets a predicate.
#' @param xs list. The list to search.
#' @param f function. The predicate function to apply. It should return TRUE or FALSE for each name element of the list.
#' @export
find <- function(xs, f) { Find(f, xs) }

#' Returns the position of the first value of a list that meets a predicate.
#' @param xs list. The list to search.
#' @param f function. The predicate function to apply. It should return TRUE or FALSE for each name element of the list.
#' @export
position <- function(xs, f) { Position(f, xs) }

#' Infix operator for map.
#' @param lhs list. The list to map over.
#' @param rhs function. The mapping function
#' @import magrittr
#' @export
`%/>%` <- function(lhs, rhs) {
  if (is.list(rhs)) {
    do.call(map, c(list(lhs), rhs))
  } else {
    lhs %>% map(rhs)
  }
}

#' Infix operator for innermap.
#' @param lhs list. The list of lists top map.
#' @param rhs function. The function to map with.
#' @import magrittr
#' @export
`%//>%` <- function(lhs, rhs) {
  if (is.list(rhs)) {
    do.call(innermap, c(list(lhs), rhs))
  } else {
    lhs %>% innermap(rhs)
  }
}

#' Infix operator for filter.
#' @param lhs list. The list to filter.
#' @param rhs function. The function to filter with.
#' @import magrittr
#' @export
`%:>%` <- function(lhs, rhs) { lhs %>% filter(rhs) }

#' Infix operator for reduce.
#' @param lhs list. The list to rduce.
#' @param rhs function. The reducing function.
#' @export
`%_>%` <- function(lhs, rhs) {
  if (is.list(rhs) && length(rhs) == 2) {
    lhs %>% reduce(rhs[[1]], rhs[[2]])
  } else {
    lhs %>% reduce(rhs)
  }
}

#' Infix operator for unlisting a list prior to mapping with a vectorized function.
#' @param lhs list. The left-hand side list to unlist and apply.
#' @param rhs function. The right-hand side vectorized function to apply to the unlisted vector. 
#' @export
`%v>%` <- function(lhs, rhs) { unlist(lhs) %>% rhs }

#' Apply a map and then flatten the result.
#' @param xs list. The list to map over.
#' @param f function. The mapping function to apply to each element of the list.
#' @import magrittr
#' @export
flatmap <- function(xs, f) { map(xs, f) %>% flatten }

#' Infix operator for flatmap.
#' @param lhs list. The list to map over.
#' @param rhs function. The function to map with.
#' @import magrittr
#' @export
`%f/>%` <- function(lhs, rhs) { lhs %>% flatmap(rhs) }

#' Filter a list to certain elements, apply a function to those elements, and return the initial list with the changed elements.
#' @param xs list. The list to iterate over.
#' @param filter_f function. The predicate function to filter the list.
#' @param map_f function. The function to apply to each element of the filter.
#' @export
filtermap <- function(xs, filter_f, map_f) {
  predicates <- which(unlist(map(xs, filter_f)))
  xs[predicates] <- map(xs[predicates], map_f)
  xs
}

#' Infix operator for filtermap
#' @param lhs list. The list to iterate over.
#' @param rhs list. A length-2 list of functions with teh first element being the filtering function and the second element being the mapping function.
#' @export
`%:/>%` <- function(lhs, rhs) { filtermap(lhs, rhs[[1]], rhs[[2]]) }

#' Reduce each sublist in a list of lists.
#' @param xs list. The list of lists to reduce.
#' @param f function. The reducing function to apply.
#' @return a list where each element of the list of lists is reduced.
#' @export
reducemap <- function(xs, f) { map(xs, function(x) { reduce(x, f) }) }

#' Infix operator for reducemap.
#' @param lhs list. The list of lists to reduce.
#' @param rhs function. The function to reduce with.
#' @export
`%_/>%` <- function(lhs, rhs) { lhs %>% reducemap(rhs) }
