#' Merge two lists together.
#' @param x list. A list to merge.
#' @param y list. A list to merge.
#' @param ... list. Additional arguments that are ignored.
#' @export
merge.list <- lmerge <- function(x, y, ...) {
  sort_keys(c(x, y[setdiff(names(y), names(x))]))
}
