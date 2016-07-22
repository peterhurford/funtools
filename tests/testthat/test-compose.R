context("compose")

test_that("fandcompose", {
  expect_equal(fandcompose(is_even, is_odd)(seq(10)), rep(FALSE, 10))
  expect_equal((is_even %&>% is_odd)(seq(10)), rep(FALSE, 10))
})

test_that("forcompose", {
  expect_equal(forcompose(is_even, is_odd)(seq(10)), rep(TRUE, 10))
  expect_equal((is_even %|>% is_odd)(seq(10)), rep(TRUE, 10))
})

test_that("%|%", {
  expect_equal(2 %|% 3, 2)
  expect_equal(NA %|% 3, 3)
  expect_equal(NULL %|% 3, 3)
  expect_equal(list() %|% 3, 3)
  options <- list(a = 1, b = 2)
  expect_equal(options$a %|% 0, 1)
  expect_equal(options$b %|% 0, 2)
  expect_equal(options$c %|% 0, 0)
})
