find <- function(xs, f) { Find(f, xs) }

null <- function(xs, f) {
  if (missing(f)) { is.null(xs) || length(xs) == 0 }
  else { is.null(find(xs, f)) }
}
