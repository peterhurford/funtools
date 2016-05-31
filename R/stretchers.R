stretch <- function(xs, n) { rep(xs, each = n) }
ldouble <- curry(stretch, n = 2)
ltriple <- curry(stretch, n = 3)
