#' @export
thread <- function(lst, fn) {
  out_list <- list(lst[[1]])
  for (i in seq(2, length(lst))) {
    out_list[[i]] <- fn(lst[[i-1]], lst[[i]])
  }
  out_list
}

#' @export
thread2 <- function(lst, fn) {
  out_list <- list(lst[[1]])
  for (i in seq(2, length(lst))) {
    out_list[[i]] <- fn(out_list[[i-1]], lst[[i]])
  }
  out_list
}


#' Continue appending to a list while the functional is true, then start appending to the next list until the input list is empty.
#' @param lst list. The input list to thread.
#' @param fn function. The function to check.
#' @export
thread_while <- function(lst, fn) {
  out_list <- list()
  i <- 1
  for (item in lst) {
    if (is.null(out_list[i][[1]])) { out_list[[i]] <- list() }
    out_list[[i]] <- append(out_list[[i]], list(item))
    if (!isTRUE(fn(item))) {
      i <- i + 1
    }
  }
  out_list
}
