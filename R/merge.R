#' Merge two lists together.
#' @param xs list. A list to merge.
#' @param ys list. A list to merge.
#' @export
merge.list <- lmerge <- function(xs, ys) {
  sort_keys(c(xs, ys[setdiff(names(ys), names(xs))]))
}
