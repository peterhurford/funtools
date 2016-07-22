#' Merge two lists together.
#' @param x list. A list to merge.
#' @param y list. A list to merge.
#' @param ... list. Additional arguments that are ignored.
#' @export
merge.list <- function(x, y, ...) {
  if (unnamed(x)) { names(x) <- rep("", length(x)) }
  if (unnamed(y)) { names(y) <- rep("", length(y)) }
  unnamed_x <- x[names(x) == ""]
  unnamed_y <- y[names(y) == ""]
  named_x <- x[names(x) != ""]
  named_y <- y[names(y) != ""]
  out <- sort_keys(c(named_x, named_y[setdiff(names(y), names(x))], unnamed_x, unnamed_y))
  if (all(names(out) == "")) { unname(out) } else { out }
}

#' @rdname merge.list
#' @export
lmerge <- merge.list
