#' @export
merge.list <- lmerge <- function(xs, ys) {
  sort_keys(c(xs, ys[setdiff(names(ys), names(xs))]))
}
