context("fn")

test_that("fn can be identity", {
  expect_equal(fn(x, x)(2), 2)
})

test_that("fn can add", {
  expect_equal(fn(x, y, x + y)(2, 3), 5)
})

test_that("fn can take many args", {
  expect_equal(fn(a, b, c, d, e, a + b - c / d * e)(1, 2, 3, 4, 5), -.75)
})

test_that("fn can be an intermediary", {
  add <- fn(x, y, x + y)
  expect_equal(add(2, 3), 5)
})

test_that("fn can have named args", {
  add <- fn(x = 1, y = 2, x + y)
  expect_equal(add(), 3)
})

test_that("fn can mix and match named args", {
  add <- fn(x = 1, y, x + y)
  expect_equal(add(y = 5), 6)
})
