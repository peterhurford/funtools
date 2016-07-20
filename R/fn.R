fn <- function(...) {
  args <- eval(substitute(alist(...)))
  body <- tail(args, 1)[[1]]
  formals <- head(args, -1)
  #TODO: formals with arguments require looking at names.
  inner_fn <- function() { }
  a <- replicate(length(formals), formals(function(x) {})[[1]])
  names(a) <- formals
  formals(inner_fn) <- a
  body(inner_fn) <- body
  inner_fn
}
