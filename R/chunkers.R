chunk <- chunk <- function(xs, n) { unname(split(xs, ceiling(seq_along(xs) / n))) }
# # R-EXP> chunk(seq(10), 3)
# # [[1]]
# # [1] 1 2 3

# # [[2]]
# # [1] 4 5 6

# # [[3]]
# # [1] 7 8 9

# # [[4]]
# # [1] 10

partition <- function(xs, f) {
  filtered <- filter(xs, f)
  list(filtered, setdiff(xs, filtered))
}
# # partition(seq(10), is_even)
# # [[1]]
# # [1]  2  4  6  8 10

# # [[2]]
# # [1] 1 3 5 7 9
