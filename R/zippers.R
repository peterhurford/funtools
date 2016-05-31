vzip <- zip <- function(xs, ys) { Map(c, xs, ys) }

lzip <- function(xs, ys) { Map(list, xs, ys) }

zip_with <- function(xs, ys, f) { Map(f, xs, ys) }

interleave <- function(xs, ys) { flatten(zip(xs, ys)) }

interpose <- function(xs, item) {
  interleave(xs, rep(item, length(xs)))
}
