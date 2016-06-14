# fn(x, y, x + y) -> function(x, y) { x + y }
# fn(x = 1, y, x + y) -> function(x = 1, y) { x + y }
fn <- function(...) {
  args <- eval(substitute(alist(...)))
  body <- tail(args, 1)[[1]]
  formals <- head(args, -1)
  #TODO: formals with arguments require looking at names.
  fn <- function() { }
  a <- replicate(length(formals), formals(function(x) {})[[1]])
  names(a) <- formals
  formals(fn) <- a
  body(fn) <- body
  fn
}
