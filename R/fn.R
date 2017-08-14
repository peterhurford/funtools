#' A shorthand for writing out R functions.
#' @param ... list. The last argument specifies the funciton body, the non-last
#'    arguments specify the formals.
#' @examples
#' add <- fn(x, y, x + y)
#' add(2, 3)
#' @export
fn <- function(...) {
  args <- eval(substitute(alist(...)))
  body <- tail(args, 1)[[1]]
  formals <- head(args, -1)
  inner_fn <- function() { }
  a <- replicate(length(formals), formals(function(x) {})[[1]])
  if (named(formals)) {
    names(a) <- lapply(c(setdiff(names(formals), ""),
                         formals[names(formals) == ""]), as.name)
    a <- merge(filter(formals, Negate(is.name)), a)
  } else {
    names(a) <- formals
  }
  formals(inner_fn) <- a
  body(inner_fn) <- body
  inner_fn
}
