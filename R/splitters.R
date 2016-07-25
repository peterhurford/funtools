#' Split a string into a list by letters.
#' @param str character. The string to split.
#' @export
lsplit <- function(str) { strsplit(str, "")[[1]] }

#' Split a string into a list by words.
#' @param str character. The string to split.
#' @export
wsplit <- function(str) { strsplit(str, " ")[[1]] }
