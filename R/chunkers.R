#' Chunk a list into multiple lists of a specific length.
#' @param xs list. The list to chunk.
#' @param n numeric. The length of each chunk.
#' @export
chunk <- function(xs, n) { unname(split(xs, ceiling(seq_along(xs) / n))) }

#' Paritition a list into two lists based on the reuslts of a binary function.
#' @param xs list. The list to partition.
#' @param f function. A function that returns TRUE or FALSE for each element
#'   into the list, determining which partition each element ends up in.
#' @export
partition <- function(xs, f) {
  filtered <- filter(xs, f)
  list(filtered, setdiff(xs, filtered))
}
