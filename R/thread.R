#' Thread a function through a list, iterating on an element and the previous
#' element.
#'
#' @param xs list. The list to iterate over.
#' @param fn function. A function that takes two arguments -- the previous
#'   position and the current position -- and returns one element back.
#' @export
thread <- function(xs, fn) {
  out_list <- list(xs[[1]])
  for (i in seq(2, length(xs))) {
    out_list[[i]] <- fn(xs[[i - 1]], xs[[i]])
  }
  out_list
}

#' Thread a function through a list, iterating on an element and the output of
#' the prior thread.
#'
#' @param xs list. The list to iterate over.
#' @param fn function. A function that takes two arguments -- the previous
#'   position and the current position -- and returns one element back.
#' @export
thread2 <- function(xs, fn) {
  out_list <- list(xs[[1]])
  for (i in seq(2, length(xs))) {
    out_list[[i]] <- fn(out_list[[i - 1]], xs[[i]])
  }
  out_list
}


#' Continue appending to a list while the functional is true, then start
#'   appending to the next list until the input list is empty.
#' @param xs list. The input list to thread.
#' @param fn function. The function to check.
#' @export
thread_while <- function(xs, fn) {
  out_list <- list()
  i <- 1
  for (x in xs) {
    if (is.null(out_list[i][[1]])) { out_list[[i]] <- list() }
    out_list[[i]] <- append(out_list[[i]], list(x))
    if (!isTRUE(fn(x))) {
      i <- i + 1
    }
  }
  out_list
}
