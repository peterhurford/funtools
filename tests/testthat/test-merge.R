context("merge")

describe("lists can be merged", {
  test_that("it works with names", {
    xs <- list(a = 1, b = 2, c = 3)
    ys <- list(d = 4, e = 5, f = 6) 
    zs <- list(a = 7, d = 8, g = 9)
    expect_equal(merge(xs, ys), list(a = 1, b = 2, c = 3, d = 4, e = 5, f = 6))
    expect_equal(merge(xs, zs), list(a = 1, b = 2, c = 3, d = 8, g = 9))
    expect_equal(merge(ys, zs), list(a = 7, d = 4, e = 5, f = 6, g = 9))
  })
  test_that("it works without names", {
    xs <- list(1, 2, 3)
    ys <- list(4, 5, 6) 
    zs <- list(7, 8, 9)
    expect_equal(merge(xs, ys), list(1, 2, 3, 4, 5, 6))
    expect_equal(merge(xs, zs), list(1, 2, 3, 7, 8, 9))
  })
  test_that("it works with a mix", {
    xs <- list(a = 1, b = 2, 3, 4)
    ys <- list(d = 5, 6, e = 7, 8) 
    zs <- list(9, a = 10, d = 11, 12)
    expect_equal(merge(xs, ys), list(a = 1, b = 2, d = 5, e = 7, 3, 4, 6, 8))
    expect_equal(merge(xs, zs), list(a = 1, b = 2, d = 11, 3, 4, 9, 12))
    expect_equal(merge(ys, zs), list(a = 10, d = 5, e = 7, 6, 8, 9, 12))
  })
})
