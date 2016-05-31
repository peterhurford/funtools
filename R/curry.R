curry <- function(curry_f, ...) {
  x <- list(...)
  function(...) { do.call(curry_f, c(list(...), x)) }
}
# subtract <- function(a, b) a - b
# f <- curry(subtract, 3)
# f(5)
# -2

f <- curry
