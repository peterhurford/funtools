merge.list <- lmerge <- function(xs, ys) {
  sort_keys(c(xs, ys[setdiff(names(ys), names(xs))]))
}

# R-EXP> merge(list(a = 1, b = 2, c = 3), list(a = 1, b = 2, e = 3))
# $a
# [1] 1

# $b
# [1] 2

# $c
# [1] 3

# $e
# [1] 3
