context("sort_keys")

describe("sort_keys", {
  test_that("it works with names", {
    expect_equal(sort_keys(list(b = 1, c = 2, a = 3)), list(a = 3, b = 1, c = 2))
  })
  test_that("it works without names", {
    expect_equal(sort_keys(list(1, 2, 3)), list(1, 2, 3))
  })
  test_that("it works with a mix", {
    expect_equal(sort_keys(list(7, b = 1, c = 2, 5, a = 3, 4)),
      list(a = 3, b = 1, c = 2, 7, 5, 4))
  })
})
